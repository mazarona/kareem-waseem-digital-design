module smem(din, addr, wr_en, rd_en, blk_select, addr_en, dout_en, clk, rst, dout, parity_out);
    parameter MEM_WIDTH = 16;
    parameter MEM_DEPTH = 1024;
    parameter ADDR_SIZE = 10;
    parameter ADDR_PIPELINE = "FALSE";
    parameter DOUT_PIPELINE = "TRUE";
    parameter PARITY_ENABLE = 1;

    input [MEM_WIDTH-1:0] din;
    input [ADDR_SIZE-1:0] addr;
    input wr_en, rd_en, blk_select, addr_en, dout_en, clk, rst;

    output [MEM_WIDTH-1:0] dout;
    output reg parity_out;
    reg [MEM_WIDTH-1:0] mem [MEM_DEPTH-1:0];

    reg [MEM_WIDTH-1:0] dout_pipelined, dout_n_pipelined;
    reg [ADDR_SIZE-1:0] addr_pipelined;
    wire [ADDR_SIZE-1:0] choosen_addr;
    always@(posedge clk)begin
        dout_pipelined <= dout_n_pipelined;
        addr_pipelined <= addr;
        if(rst)
            dout_n_pipelined <= 0;
        else if(blk_select) begin
            if(wr_en) 
                mem[choosen_addr] <= din;
            if(rd_en)
                dout_n_pipelined <= mem[choosen_addr];
        end
    end

    // Handling parity bit
    always@(*) begin
        if(PARITY_ENABLE)
            parity_out = (dout%2 == 0)? 1 : 0;
        else 
            parity_out = 0;
    end

    assign choosen_addr = (addr_en && (ADDR_PIPELINE == "TRUE"))? addr_pipelined : addr; 
    assign dout = (dout_en && (DOUT_PIPELINE == "TRUE"))? dout_pipelined : dout_n_pipelined;


endmodule
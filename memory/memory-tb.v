module smem_tb();
    reg wr_en, rd_en, blk_select, addr_en, dout_en, clk, rst;
	reg [15:0] din;
	reg [9:0] addr;
	wire [15:0] dout;

    smem memory(din, addr, wr_en, rd_en, blk_select, addr_en, dout_en, clk, rst, dout, parity_out);

    //clock generation
    initial begin
        clk = 0;
        forever
          #1 clk = ~clk;
    end

	integer i;
	//reset and initial values for inputs
    initial begin
        addr_en = 0;
        dout_en = 1;
        blk_select = 1;
        rst = 1;
        $readmemh ("mem.dat", memory.mem);
        #2 rst = 0;
        //Write
        rd_en = 0;
        wr_en = 1;
        for (i = 0; i < 10; i=i+1) begin
            #2 addr = i; din = $random;
        end
        //Read
        i = 0;
        wr_en = 0;
        rd_en = 1;
        for (i = 0; i < 10; i=i+1) begin
            #2 addr = i;
        end
        $stop;
    end

    //monitor
    initial begin
        $monitor("rst = %h, blk_select = %h, rd_en = %h, wr_en = %h, addr_en = %h, dout_en = %h\ndin = %h, addr = %h, dout = %h, parity_out = %h\n",
        rst, blk_select, rd_en, wr_en, addr_en, dout_en, din, addr, dout, parity_out);
    end
endmodule
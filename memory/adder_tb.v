module adder(a, b, clk, cin, rst, sum, cout, parity_out);
    parameter WIDTH = 4;
    parameter PIPELINE_ENABLE = 1;
    parameter USE_FULL_ADDER = 1;

    input [WIDTH-1:0] a, b;
    input clk, cin, rst;
    output [WIDTH-1:0] sum;
    output cout;
    output parity_out;

    reg [WIDTH-1:0] sum_pipelined; 
    reg cout_pipelined;
    reg [WIDTH-1:0] sum_n_pipelined; 
    reg cout_n_pipelined;

    always@(*) begin
        if(rst)
            sum_n_pipelined = 0;
        else begin
            if(USE_FULL_ADDER)
                {cout_n_pipelined, sum_n_pipelined} = a + b + cin;
            else
                {cout_n_pipelined, sum_n_pipelined} = a + b;
        end
    end

    always@(posedge clk) begin
        cout_pipelined <= cout_n_pipelined;
        sum_pipelined <= sum_n_pipelined;
    end

    assign {cout, sum} = (PIPELINE_ENABLE)? {cout_pipelined, sum_pipelined} : {cout_n_pipelined, sum_n_pipelined};
    assign parity_out = (sum%2 == 0)? 1 : 0;

endmodule
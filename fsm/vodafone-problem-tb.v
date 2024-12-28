module vodafone_tb();
    reg x, clk, rst;
    wire y;
    wire[9:0] users_count;
    vodafone dut(x, clk, rst, y, users_count);


    //clock generation
    initial begin
        clk = 0;
        forever
            #1 clk = ~clk;
    end

    //
    always@(posedge clk) begin
        $display("Input = %h, NS = %h, CS = %h, Output:y = %h, Output:users_count = %h", x, dut.ns, dut.cs, y, users_count);
    end
    integer i;
    initial begin
        rst = 1;
        #2;
        rst = 0;
        x = 1;
        for(i = 0; i < 100; i = i+1) begin
            x = ~x;
            #2;
        end
        $stop;
    end
endmodule
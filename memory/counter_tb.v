module tb();
    reg clk, rstn;
    wire [3:0] out1, out2;

    counter counter1(clk, rstn, out1);
    rc counter2(clk, rstn, out2);

    initial begin
        clk = 0;
        forever
            #1 clk = ~clk;
    end

    initial begin
        $monitor("out1 = %h, out2 = %h", out1, out2);
    end

    initial begin
        rstn = 0;
        #10 rstn = 1;
        #40;
        $stop;

    end

endmodule
// (TESTBENCH) D-type flip-flop with active high enable and asynchronous active low preset
module d_type_ff_tb();
    reg d, e, clk, pre;
    wire q;
    d_type_ff f(d, e, clk, pre, q);
    initial begin
        clk = 0;
        forever begin
            #1;
            clk = ~clk;
        end
    end
    integer i;
    initial begin
        pre = 0;
        #2;
        $display("pre = %h, e = %h, d = %h, q = %h", pre, e, d, q);
        pre = 1;
        e = 0;
        #2;
        $display("pre = %h, e = %h, d = %h, q = %h", pre, e, d, q);
        e = 1;
        for(i = 0; i < 10; i = i + 1) begin
            #2
            d = $random;
            $display("pre = %h, e = %h, d = %h, q = %h", pre, e, d, q);
        end
        $stop;
    end
endmodule
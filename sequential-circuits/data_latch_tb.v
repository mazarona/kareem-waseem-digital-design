module data_latch_tb();
    reg d, g, clr; 
    wire q;
    data_latch dl(d, g, clr, q);
    integer i;
    initial begin
        clr = 0;
        #10;
        $display("clr = %h, g = %h, d = %h, q = %h",clr, g, d,q);
        clr = 1;
        for(i = 0; i < 4; i = i + 1) begin
            {g, d} = i;
            #10;
            $display("clr = %h, g = %h, d = %h, q = %h",clr, g, d,q);
        end
        $stop;
    end
endmodule
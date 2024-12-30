module data_latch(d, g, clr, q);
    input d, g, clr;
    output reg q;
    always @(*)begin
        if(~clr)
            q <= 0;
        else if(g)
            q <= d;
    end
endmodule
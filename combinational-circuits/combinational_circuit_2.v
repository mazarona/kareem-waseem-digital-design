module circuit2(a, b, c, d, sel, out, out_bar);
    input a, b, c, sel;
    input [2:0] d;
    output reg out, out_bar;
    always @(*)begin
        if(sel == 0)
            out = d[0] & d[1] | d[2];
        else if (sel == 1)
            out = ~(a ^ b ^ c);
        out_bar = ~out;
    end
endmodule

module circuit1(a, b, c, d, e, f, sel, out, out_bar);
    input a, b, c, d, e, f, sel;
    output out, out_bar;
    wire n1, n2;

    assign n1 = a & b & c;
    assign n2 = ~(d ^ e ^ f);

    assign out = (sel == 0)? n1 : n2; 
    assign out_bar = ~out;
endmodule

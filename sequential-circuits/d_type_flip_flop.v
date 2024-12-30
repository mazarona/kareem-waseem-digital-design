// D-type flip-flop with active high enable and asynchronous active low preset
module d_type_ff(d, e, clk, pre, q);
    input d, e, clk, pre;
    output reg q;
    always@(posedge clk, negedge pre) begin
        if(~pre)
            q <= 1;
        else if(e)
            q <= d;
    end
endmodule
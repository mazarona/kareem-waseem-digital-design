module dff(d, rstn, clk, q, qbar);
    input d, rstn, clk;
    output reg q;
    output qbar;

    always@(posedge clk, negedge rstn) begin
        if(~rstn)
            q <= 0;
        else
            q <= d;
    end

    assign qbar = ~q;
endmodule

module counter(clk, rstn, out);
    input clk, rstn;
    output reg [3:0] out;
    always@(posedge clk, negedge rstn) begin
        if(~rstn)
            out <= 0;
        else
            out = (out + 1)%16;
    end
    
endmodule

module rc(clk, rstn, out);
    input clk, rstn;
    wire q0, q1, q2, q3;
    output [3:0] out;

    dff dff1(out[0], rstn, clk, q0, out[0]);
    dff dff2(out[1], rstn, q0, q1, out[1]);
    dff dff3(out[2], rstn, q1, q2, out[2]);
    dff dff4(out[3], rstn, q2, q3, out[3]);

endmodule
module latch(data, aset, gate, aclr, q);
    parameter LAT_WIDTH;
    input [LAT_WIDTH-1:0] data;
    input aset, gate, aclr;
    output reg [LAT_WIDTH-1:0] q;
    always @(*) begin
        if(aclr)
            q <= 0;
        else if(aset)
            q <= 1;
        else if(gate)
            q <= data;
    end
endmodule
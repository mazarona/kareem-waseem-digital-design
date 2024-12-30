module sr(sclr, sset, shiftin, load, data, clock, enable, aclr, aset, shiftout, q);
    parameter LOAD_AVALUE = 8;
    parameter SHIFT_DIRECTION = "LEFT";
    parameter LOAD_SVALUE = 4;
    parameter SHIFT_WIDTH = 8;
    input sclr, sset, shiftin, load, clock, enable, aclr, aset;
    input [SHIFT_WIDTH-1:0] data;


    output reg shiftout;
    output reg [SHIFT_WIDTH-1:0] q;

    always@(posedge clock, posedge aclr, posedge aset) begin
        if(aclr)
            q <= 0;
        else if(aset)
            q <= LOAD_AVALUE;
        else if(sclr)
            q <= 0;
        else if(sset)
            q <= LOAD_SVALUE;
        else if(enable)begin
            if(load)
                q <= data;
            else begin
                if(SHIFT_DIRECTION == "LEFT")
                    {shiftout, q} = {q[SHIFT_WIDTH-1:0], shiftin};
                else if(SHIFT_DIRECTION == "RIGHT")
                    {q, shiftout} = {shiftin, q[SHIFT_WIDTH-1:0]};
            end
        end
    end
endmodule
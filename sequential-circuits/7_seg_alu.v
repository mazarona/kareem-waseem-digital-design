// n-bit ALU
module alu(a, b, opcode, result);
    parameter W;
    input [W-1:0] a, b;
    input [1:0] opcode;
    output reg [W-1:0] result;
    always @(*)begin
        case(opcode)
            2'b00 : result = a + b;
            2'b01 : result = a - b;
            2'b10 : result = a | b;
            2'b11 : result = a ^ b;
        endcase
    end
endmodule

// n-bit ALU connected to a 7-seg display
module alu_7seg(a, b, opcode, e, out);
    input [3:0] a, b;
    input [1:0] opcode;
    input e;
    output reg [7:0] out;

    wire [3:0] result;
    alu #(4) alu(a, b, opcode, result);
    always@(*) begin
        if(e) begin
            case(result)
                4'h0 : out = 8'h3f;
                4'h1 : out = 8'h06;
                4'h2 : out = 8'h5b;
                4'h3 : out = 8'h4f;
                4'h4 : out = 8'h66;
                4'h5 : out = 8'h6d;
                4'h6 : out = 8'h7d;
                4'h7 : out = 8'h07;
                4'h8 : out = 8'h7f;
                4'h9 : out = 8'h6f;
                4'ha : out = 8'h77;
                4'hb : out = 8'h7c;
                4'hc : out = 8'h39;
                4'hd : out = 8'h5e;
                4'he : out = 8'h79;
                4'hf : out = 8'h71;
            endcase
        end
        else
            out = 0;
    end
endmodule
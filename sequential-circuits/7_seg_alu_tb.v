// (TESTBENCH) n-bit ALU connected to a 7-seg display
module alu_7seg_tb();
    reg [3:0] a, b;
    reg [1:0] opcode;
    reg e;
    wire [7:0] out;
    alu_7seg alu_tb(a, b, opcode, e, out);

    integer i;
    initial begin
        e = 0;
        #2;
        $display("enable = %h, opcode = %h, A = %h, B = %h, output = %h", e, opcode, a, b, out);
        e = 1;
        for(i = 0; i < 10; i = i + 1) begin
            {a, b, opcode} = $random;
            #2;
            $display("enable = %h, opcode = %h, A = %h, B = %h, output = %h", e, opcode, a, b, out);
        end
        $stop;
    end
endmodule
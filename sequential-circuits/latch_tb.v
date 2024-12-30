module latch_tb();
    reg [3: 0] data;
    reg aset, gate, aclr;
    wire [3:0] q;
    latch #(4) l(data, aset, gate, aclr, q);
    integer i;
    initial begin
        aclr = 1;
        aset = 1;
        #10;
        $display("aclr = %h, aset = %h, gate = %h, data = %h, q = %h", aclr, aset, gate, data, q);
        aclr = 0;
        #10;
        $display("aclr = %h, aset = %h, gate = %h, data = %h, q = %h", aclr, aset, gate, data, q);
        aset = 0;
        #10;
        $display("aclr = %h, aset = %h, gate = %h, data = %h, q = %h", aclr, aset, gate, data, q);
        gate = 0;
        for(i = 0; i < 10; i = i + 1) begin
            gate = ~gate;
            data = $random;
            #10;
            $display("aclr = %h, aset = %h, gate = %h, data = %h, q = %h", aclr, aset, gate, data, q);
        end
        $stop;
    end
endmodule
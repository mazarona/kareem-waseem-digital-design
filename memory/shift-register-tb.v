module sr_tb();
    reg sclr, sset, shiftin, load, clock, enable, aclr, aset;
    reg [7:0] data;

    wire shiftout;
    wire [7:0] q;
    sr sr_dut(sclr, sset, shiftin, load, data, clock, enable, aclr, aset, shiftout, q);

    //clock generation
    initial begin
        clock = 0;
        forever
            #1 clock = ~clock;
    end

    //monitor
    initial begin
        $monitor("INPUTS : aclr = %h, aset = %h, sclr = %h, sset = %h, enable = %h, load = %h, data = %b, shiftin = %h\nOUTPUTS: q = %b, shiftout = %h\n------------------------"
        , aclr, aset, sclr, sset, enable, load, data, shiftin, q, shiftout);
    end

    integer i;
    initial begin
        {shiftin, data} = $random;
        //test async signals
        aclr = 1;
        #2 aclr = 0; aset = 1;
        #2 aclr = 1;
        //test enable signal and data loading
        #2 {aclr, aset, enable} = 0; load = 1;
        #2 enable = 1; 
        //test sync signals
        #2 sclr = 1;
        #2 sclr = 0; sset = 1;
        #2 sclr = 1;
        //test shifting operation (left)
        #2 {sclr, sset} = 0;
        #2 load = 0;
        for(i = 0; i < 8; i = i + 1)
            #2 shiftin = $random;
        $stop;
    end
endmodule
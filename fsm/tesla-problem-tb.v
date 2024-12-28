module tesla_tb();
    parameter STOP = 2'b00;
    parameter ACCELERATE = 2'b01;
    parameter DECELERATE = 2'b10;
    parameter MIN_DISTANCE = 7'd40;
    reg [7:0] speed_limit;
    reg [7:0] car_speed;
    reg [6:0] leading_distance;
    reg clk, rst;
    wire unlock_doors, accelerate_car;
    tesla dut(speed_limit, car_speed, leading_distance, clk, rst, unlock_doors, accelerate_car);

    // clock generation
    initial begin
        clk = 0;
        forever
            #1 clk = ~clk;
    end

    always@(posedge clk)begin
        $display("speed_limit = %d, car_speed = %d, leading_distance = %d, unlock_doors = %d, accelerate_car = %d, CS = %d",
                    speed_limit, car_speed, leading_distance, unlock_doors, accelerate_car, dut.cs);
    end
    integer i = 0;
    initial begin
        rst = 1;
        #2;
        $display("Testing changing car speed above the limit: ");
        speed_limit = 50;
        leading_distance = 100;
        car_speed = 0;
        rst = 0;
        // test car speed
        for(i = 0;i < 12; i = i +1)begin
            if(dut.cs == ACCELERATE)
                car_speed = car_speed + 10;
            else if(dut.cs == DECELERATE)
                car_speed = car_speed - 2;
            #2;
        end
        $display("Testing changing leading distance below the minimum 40: ");
        speed_limit = 100;
        leading_distance = 100;
        for(i = 0;i < 10; i = i +1)begin
            if(dut.cs == ACCELERATE) begin
                car_speed = car_speed + 5;
                leading_distance = leading_distance - 10;
            end
            else if(dut.cs == DECELERATE)begin
                car_speed = car_speed - 2;
                leading_distance = leading_distance - 5;
            end
            #2;
        end
        $stop;
    end

endmodule
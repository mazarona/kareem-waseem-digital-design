module tesla(speed_limit, car_speed, leading_distance, clk, rst, unlock_doors, accelerate_car);
    parameter STOP = 2'b00;
    parameter ACCELERATE = 2'b01;
    parameter DECELERATE = 2'b10;
    parameter MIN_DISTANCE = 7'd40;
    input [7:0] speed_limit;
    input [7:0] car_speed;
    input [6:0] leading_distance;
    input clk, rst;
    output unlock_doors, accelerate_car;

    reg [1:0] cs, ns;

    //State Memory
    always@(posedge clk or posedge rst) begin
        if(rst) cs <= STOP;
        else cs <= ns;

    end

    //Next state logic
    always@(cs, speed_limit, car_speed, leading_distance) begin
        case(cs)
            STOP: 
                if(leading_distance >= MIN_DISTANCE) 
                    ns = ACCELERATE; 
                else 
                    ns = STOP;
            ACCELERATE: 
                if(leading_distance < MIN_DISTANCE || car_speed > speed_limit) 
                    ns = DECELERATE;
                else 
                    ns = ACCELERATE;
            DECELERATE:
                if(car_speed == 0)
                    ns = STOP;
                else if(leading_distance < MIN_DISTANCE || car_speed > speed_limit) 
                    ns = DECELERATE;
                else 
                    ns = ACCELERATE;
        endcase
    end

    //Output logic
    assign unlock_doors = (cs == STOP)? 1 : 0;
    assign accelerate_car = (cs == ACCELERATE)? 1 : 0;


endmodule

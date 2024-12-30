module vodafone(x, clk, rst, y, users_count);
    parameter A = 2'b000;
    parameter B = 2'b001;
    parameter C = 2'b010;
    parameter D = 2'b011;
    parameter WAIT = 3'b100;

    reg [2:0] cs, ns;
    input x, clk, rst;
    output  y;
    output [9:0] users_count;

    /* A flag used to control the users_count counter */
    wire increment_users;

	/* stay in WAIT state till counter reaches 8 to skip 8 nubmers after 010 */
    wire [3:0] c1_out;
    wire c1_input;
    wire start_c1;
    and(c1_input, clk, start_c1);
    assign start_c1 = (cs == WAIT)? 1 : 0;
    up_counter_UB #(.W(4), .UPPER_BOUND(8)) c1(c1_input, rst, c1_out);


    //State Memory
    always@(posedge clk or posedge rst)begin
        if(rst) cs <= A;
        else cs <= ns;
    end

    //Next state logic
    always@(cs, x, c1_out)begin
        case(cs)
            A: if(x) ns = A; else ns = B;
            B: if(x) ns = C; else ns = B;
            C: if(x) ns = A; else ns = D;
            D: ns = WAIT;
            WAIT:
                if(c1_out == 8) begin
                    if(x) ns = A;
                    else ns = B;
                end
                else ns = WAIT;
        endcase
    end

    //Output logic
    assign y = (cs == D)? 1 : 0;
    // we should increment_users when c1_out reaches 7 not 8 (Off by one bug)
    assign increment_users = (c1_out == 7)? 1 : 0;
    up_counter #(10) c2(increment_users, rst, users_count);
endmodule

module up_counter_UB(clk, reset, counter_up);
    parameter W = 4;
    parameter UPPER_BOUND = 8;
    input clk, reset;
    output reg [W-1:0]counter_up;
    always@(posedge clk or posedge reset)begin
        if(reset)
            counter_up <= 0;
        else if(counter_up == UPPER_BOUND)
            counter_up <= 0;
        else
            counter_up <= counter_up + 1;
    end
endmodule

module up_counter(clk, reset, counter_up);
    parameter W = 4;
    input clk, reset;
    output reg [W-1:0]counter_up;
    always@(posedge clk or posedge reset)begin
        if(reset)
            counter_up <= 0;
        else
            counter_up <= counter_up + 1;
    end
endmodule
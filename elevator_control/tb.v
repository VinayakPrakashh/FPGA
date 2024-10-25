`timescale 1ns / 1ps
module tb_elevator_control_top;

    // Inputs
    reg clk;
    reg [3:0] requested_floor;
    reg sensor;
    reg open_close_door;

    // Outputs
    wire [3:0] current_floor;
    wire elevator_direction;
    wire door_open;

    // Instantiate the Unit Under Test (UUT)
    elevator_control_top uut (
        .clk(clk),
        .requested_floor(requested_floor),
        .sensor(sensor),
        .open_close_door(open_close_door),
        .current_floor(current_floor),
        .elevator_direction(elevator_direction),
        .door_open(door_open)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        requested_floor = 4'b0000;
        sensor = 0;
        open_close_door = 0;

        // Wait for global reset
        #10;
        requested_floor = 4'b0011;
        #7;
        requested_floor = 4'b1000;
        sensor<=1; // Clear request
        #100
        sensor<=0;
        requested_floor = 4'b0000;
//        // Wait for elevator to reach floor 3
//        #100;

//        // Test Case 2: Request floor 1 while at floor 3
//        #10;
//        requested_floor = 4'b0001;
//        #10;
//        requested_floor = 4'b0000; // Clear request

//        // Wait for elevator to reach floor 1
//        #100;

//        // Test Case 3: Request multiple floors (2 and 4)
//        #10;
//        requested_floor = 4'b0010;
//        #10;
//        requested_floor = 4'b0100;
//        #10;
//        requested_floor = 4'b0000; // Clear request

//        // Wait for elevator to process all requests
//        #200;

//        // Test Case 4: Open and close door manually
//        #10;
//        open_close_door = 1;
//        #10;
//        open_close_door = 0;

//        // Wait for some time
//        #50;

//        // Test Case 5: Sensor activation
//        #10;
//        sensor = 1;
//        #10;
//        sensor = 0;

//        // Wait for some time
//        #50;

//        // Finish simulation
//        $stop;
    end
 initial begin
        $monitor("Time: %t | last_floor=%d |  Current Floor: %d | Requested Floor: %d | Head: %d | Tail: %0d | Queue: %d | State: %0d | Direction: %b | Door Open: %b", 
                 $time, uut.last_requested_floor,current_floor, requested_floor, uut.head, uut.tail, uut.queue[0], uut.state, elevator_direction, door_open);
    end
endmodule

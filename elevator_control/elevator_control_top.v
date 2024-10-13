    module elevator_control_top (
        input  clk,
        input  [3:0] requested_floor,
        input  sensor,
        input  open_close_door,
        output reg [3:0] current_floor,
        output  elevator_direction,
        output  door_open
    );
    
    parameter IDLE=2'b00, MOVING_UP =2'b01, MOVING_DOWN =2'b10, DOOR_OPEN =2'b11;
        reg [3:0] state; // State of the elevator
        // Queue definitions
        reg [3:0] queue [0:15]; // Queue to store up to 16 floor requests
        reg [3:0] head; // Points to the front of the queue
        reg [3:0] tail; // Points to the end of the queue
        reg [4:0] timer; // Timer for door open state
        reg [3:0] last_requested_floor;
        // Initialize the queue pointers
        initial begin
                 head <= 0;
                tail <= 0;
                state <= IDLE;
                current_floor <= 0;
                timer <= 0;
                last_requested_floor<=0;
        end
 
        always @(posedge clk) begin
             
                // Add requested floor to the queue
                if (last_requested_floor!=requested_floor) begin
                    queue[tail] <= requested_floor;
                    tail <= tail + 1;
                    last_requested_floor <= requested_floor;
                    end
       if(sensor | open_close_door) begin state <=IDLE; end
                else begin
                // State machine
                case (state)
                    IDLE: begin
                        if (head != tail) begin
                            if (current_floor < queue[head]) begin
                                state <= MOVING_UP;
                            end else if (current_floor > queue[head]) begin
                                state <= MOVING_DOWN;
                            end else begin
                                state <= DOOR_OPEN;
                            end
                        end
                    end
                    MOVING_UP: begin
                        if (current_floor == queue[head]) begin
                            state <= DOOR_OPEN;
                        end else begin
                            current_floor <= current_floor + 1;
                        end
                    end
                    MOVING_DOWN: begin
                        if (current_floor == queue[head]) begin
                            state <= DOOR_OPEN;
                        end else begin
                            current_floor <= current_floor - 1;
                        end
                    end
                    DOOR_OPEN: begin
                        if (timer == 5'b11111) begin
                            state <= IDLE;
                            head <= head + 1; // Move to the next request in the queue
                            timer <= 0;
                        end else begin
                            timer <= timer + 1;
                        end
                    end
                    default: state <= IDLE;
                endcase
                end
            end
       
    
        assign elevator_direction = (state == MOVING_UP) ? 1 : (state==MOVING_DOWN)?0:1'bx;
        assign door_open = (state == DOOR_OPEN | sensor | (open_close_door & state == IDLE)) ? 1 : 0;
    
    endmodule

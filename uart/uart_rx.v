// EcoMender Bot : Task 2A - UART Receiver
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is used to receive UART Rx data packet from receiver line and then update the rx_msg and rx_complete data lines.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

/*
Module UART Receiver

Baudrate: 230400 

Input:  clk_3125 - 3125 KHz clock
        rx      - UART Receiver

Output: rx_msg - received input message of 8-bit width
        rx_parity - received parity bit
        rx_complete - successful uart packet processed signal
*/

// module declaration
module uart_rx(
    input clk_3125,
    input rx,
    output reg [7:0] rx_msg,
    output reg rx_parity,
    output reg rx_complete
    );

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////
parameter IDLE = 0, START_BIT = 1, DATA_BITS = 2, PARITY_BIT = 3, STOP_BIT = 4;

reg [2:0] state;
reg [3:0] counter=-1;
reg c_parity=0,rx_parity_reg=0;
reg [3:0] data_counter=0;
reg [7:0] rx_msg_reg=0;
initial begin
    rx_msg = 0;
	 
	  rx_parity = 0;
    rx_complete = 0;
end

always @(posedge clk_3125) begin
counter = counter+1;


case(state)

	IDLE: begin 
		if(rx == 0) begin state <=START_BIT; rx_complete<=0; end
    end
    START_BIT: begin
        if(counter == 14) begin state <=DATA_BITS; counter <=0; end
    end
    DATA_BITS: begin
        if(data_counter < 8) begin 
            if(counter == 14) begin
                rx_msg_reg[7-data_counter] <= rx;
                data_counter <= data_counter + 1;
                counter <=0;
            end
        end
        else begin state <=PARITY_BIT; data_counter<=0; end
        end
    PARITY_BIT: begin
 c_parity <= (^rx_msg_reg);
		rx_parity_reg<=rx;
		if(counter==14) begin 	state<= STOP_BIT; counter<=0; end
    end
	 STOP_BIT: begin
	 if(rx_parity_reg!==c_parity) begin rx_msg_reg<=8'h3f; end
	 if(counter==14) begin state<=IDLE;
	 rx_msg<=rx_msg_reg; counter<=0;  rx_complete<=1; rx_parity<=rx_parity_reg; end
	 end
    default: state <=IDLE;
endcase
end
//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////


endmodule


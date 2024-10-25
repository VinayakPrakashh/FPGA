// EcoMender Bot : Task 2A - UART Transmitter
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is used to generate UART Tx data packet to transmit the messages based on the input data.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

/*
Module UART Transmitter

Input:  clk_3125 - 3125 KHz clock
        parity_type - even(0)/odd(1) parity type
        tx_start - signal to start the communication.
        data    - 8-bit data line to transmit

Output: tx      - UART Transmission Line
        tx_done - message transmitted flag
*/

// module declaration
module uart_tx(
    input clk_3125,
    input parity_type,tx_start,
    input [7:0] data,
    output reg tx, tx_done
);

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

parameter IDLE = 0, START_BIT = 1, DATA_BITS = 2, PARITY_BIT = 3, STOP_BIT = 4;

reg [2:0] state=0;
reg [3:0] counter=0;
reg [2:0] d_count=3'b111;
initial begin

	 tx=1;
    tx_done = 0;
end

always @(posedge clk_3125) begin
	 
    counter <= counter + 1;
    case (state)
        IDLE:begin        if(counter == 0) begin
            tx_done <=0;
        end 
		  if(tx_start) begin state<= START_BIT; counter <=1; tx<=0;  end	
end
    START_BIT: begin
	     tx <=0;
        if(counter == 13) begin
            state <=DATA_BITS;
            counter <=0;
        end
		  end
    DATA_BITS:begin
	    tx<=data[d_count];
                if (counter == 4'b1101) begin
						 if(d_count==0)begin
						  d_count<=3'b111;
						  counter<=4'b0;
						  state<=PARITY_BIT;
						end else begin
						  counter<=4'b0;
						  d_count<=d_count-1;
						end
					 end
    end
    PARITY_BIT:begin
    tx<=(^data) ^ parity_type;
        if(counter == 13) begin
            state <=STOP_BIT;
            counter <=0;
        end
    end
    STOP_BIT:begin
   tx<=1;
    if(counter == 13) begin
        state <=IDLE;
        tx_done <=1;
        counter <=0;
    end
    end
    endcase
end
//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule
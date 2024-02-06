`timescale 1ns / 1ps
module JK(
    input J,K,clk,
    output reg Q,Qn
    );
    
    always @(posedge clk)
    begin 
    case ({J,K})
    2'b00: Q = Q;
    2'b10: Q = 1;
    2'b01: Q = 0;
    2'b11: Q = ~Q; 
    endcase
    assign Qn = ~Q;
    end
   
endmodule

`timescale 1ns / 1ps

module bcd_adder(a,b,sum,carry
    );
    input [3:0] a,b;
    output reg [3:0] sum;
    output  reg carry;
    reg [4:0] sum_temp;
    
    always @(a,b)
    begin
    sum_temp = a+b;
    if(sum_temp>9) begin
    sum_temp = sum_temp+6;
    sum = sum_temp[3:0];
    carry = 1;
    end
    else begin 
    carry = 0;
    sum = sum_temp[3:0];
    end
    end
endmodule

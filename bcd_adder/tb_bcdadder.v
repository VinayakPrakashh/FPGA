`timescale 1ns / 1ps

module tb_bcdadder;

    // Inputs
    reg [3:0] a;
    reg [3:0] b;

    // Outputs
    wire [3:0] sum;
    wire carry;
    
    
    bcd_adder uut (
        .a(a), 
        .b(b),  
        .sum(sum), 
        .carry(carry)
    );

    initial begin
        a = 0;  b = 0;   #100;
        a = 6;  b = 9;   #100;
        a = 3;  b = 3;   #100;
        a = 4;  b = 5;   #100;
        a = 8;  b = 2;   #100;
        a = 9;  b = 9;   #100;
    end
    initial begin
    $monitor("a=%0b b=%0b sum=%0b carry=%0b",a,b,sum,carry) ;
    end
endmodule

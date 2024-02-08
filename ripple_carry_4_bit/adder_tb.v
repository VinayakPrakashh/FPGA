`timescale 1ns / 1ps
module ripple_adder_tb;
reg[3:0] x,y;
reg c_in;
wire [3:0]s;

wire cy4;
bit4_ripple dut(.x(x),.y(y),.c_in(c_in),.s(s),.cy4(cy4));
initial begin
x = 4'b1111;
y = 4'b1111;
c_in = 1'b0;

#50
x = 4'b1110;
y = 4'b1100;
#50
x = 4'b1100;
y = 4'b1100;
 
end
endmodule

`timescale 1ns / 1ps

module JK_tb;
reg J,K,clk;
wire Q,Qn;
JK dut(J,K,clk,Q,Qn);
initial begin
clk = 0;
forever #5 clk = ~clk;
end
initial begin
J =1; K = 0;
#50
J = 0; K = 0;
#50
J = 0; K =1;
#50
J = 1; K = 1;
$finish;
end
endmodule

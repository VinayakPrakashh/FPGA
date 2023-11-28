`timescale 1ns / 1ps
module jk_tb;
reg j,k,clk;
always #5clk=~clk;
jk_FF dut(.j(j),.k(k),.clk(clk),.q(q));
initial begin
j <= 0;
k <= 0;
#500
j <= 1;
#500
j<=0;
k<=1;
#500
j<=1;
#500
$finish;
end
initial begin
$monitor ("j=%0d k=%0d q=%0d", j, k, q); 
end
endmodule

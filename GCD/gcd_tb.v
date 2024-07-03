`timescale 1ns / 1ps
module gcd_tb;
reg [15:0] data_in;
reg clk,start;
wire done;
wire [15:0] gcd_out;
data_path gcd(gt,lt,eq,ldA,ldB,sel1,sel2,sel_in,data_in,clk,gcd_out);
control_path control(ldA,ldB,sel1,sel2,sel_in,done,clk,lt,gt,eq,start);
always #5 clk = ~clk;
initial begin
clk = 1'b0;
#3 start = 1'b1;
#1000 $finish;
end
initial begin
#12 data_in = 123;
#10 data_in = 27;
end
initial begin
$monitor ($time,"%d %b",gcd.Aout,done);
end
endmodule

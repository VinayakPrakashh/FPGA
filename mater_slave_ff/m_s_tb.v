`timescale 1ns / 1ps
module m_s_tb;
reg clk;
reg rst;
reg j;
reg k;
wire q;
wire qn;
m_s_ff dut (
  .q(q),
  .qn(qn),
  .clk(clk),
  .rst(rst),
  .j(j),
  .k(k)
);

initial begin
  // Initialize signals
  clk = 0;
  rst = 1;
  j = 0;
  k = 0;

  #5 rst = 0; // Reset for 5 clock cycles

  // Set j to 1 for 5 clock cycles
  #100 j = 1;
  #100 j = 0;

  // Set k to 1 for 5 clock cycles
  #100 k = 1;
  #100 k = 0;

  #100
$stop;
end

always #5 clk = ~clk;
initial begin
$monitor("j=%0d k=%d q=%d",j,k,q);
end

endmodule

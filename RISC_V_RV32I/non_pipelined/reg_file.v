`timescale 1ns / 1ps
module reg_file (
input WE,RE,
input [4:0] RW_addr,RD1_addr,
input [31:0] WR1,
output reg [31:0] RD1,RD2
);
reg [31:0] Reg [31:0];

always @(*) begin
if(WE==1'b1) Reg[RW_addr] <= WR1;
 else if (RE==1'b1)begin 
      RD1 <= Reg[RW_addr];
      RD2 <= Reg[RD1_addr];
      end
end
initial begin
Reg[0] <= 32'h24ff43ff;
Reg[1] <= 32'h3452f456;
end
endmodule
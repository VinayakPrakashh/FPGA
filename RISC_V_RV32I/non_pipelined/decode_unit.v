`timescale 1ns / 1ps
//`include "reg_file.v"
module decode_unit (
IR,A,B,WE,RE,RW_addr,RD1_addr,RD1,RD2,WR1
);
input [31:0] IR;
output  [31:0] A,B;
output WE,RE;
output [4:0] RW_addr,RD1_addr;
input [31:0] RD1,RD2;
output [31:0] WR1;
assign WE=0;
assign RE=1;
assign RW_addr=IR[19:15];
assign RD1_addr=IR[24:20];
assign A=RD1;
assign B=RD2;
assign WR1=0;
endmodule
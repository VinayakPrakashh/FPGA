`timescale 1ns / 1ps
module sign_extend(IR,imm_sel,imm);
//inputs
input [31:0] IR;
input [1:0] imm_sel;
//outputs
output [31:0] imm;

assign imm = (imm_sel == 2'b01) ? {{20{IR[31]}},{IR[31:20]}}: //I_TYPE
             (imm_sel == 2'b10) ? {{20{1'b0}},{IR[31:25]},{IR[11:7]}} : //B_TYPE, S_TYPE
             (imm_sel == 2'b11) ? {{{12{1'b0}}, IR[31:12]}} : //J_TYPE
             {{20{1'b0}},IR[31:20]} ;// L_TYPE
endmodule
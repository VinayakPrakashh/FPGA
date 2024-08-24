`timescale 1ns / 1ps
module main_decoder (opcode,imm_sel,alu_type_sel,b_imm_sel,branch,jump,memwrite_en,regwrite_en,wb_sel);
//inputs
input [6:0] opcode;
//outputs
output [1:0] imm_sel,alu_type_sel;
output b_imm_sel,branch,jump,memwrite_en,regwrite_en,wb_sel;
//parameters
parameter R_TYPE = 7'b0110011, I_TYPE = 7'b0010011, B_TYPE = 7'b1100011, L_TYPE = 7'b0000011, S_TYPE = 7'b0100011,J_TYPE = 7'b1101111;

assign imm_sel = (opcode == I_TYPE) ? 2'b01 : (opcode == B_TYPE | opcode == S_TYPE) ? 2'b10 :(opcode == J_TYPE) ? 2'b11: 2'b00;
assign regwrite_en = (opcode == L_TYPE | opcode == R_TYPE | opcode == I_TYPE ) ? 1'b1 : 1'b0 ;
assign alu_type_sel = (opcode == R_TYPE | opcode == I_TYPE) ? 2'b01 : (opcode == B_TYPE) ? 2'b10 : 2'b00;
assign memwrite_en = (opcode == S_TYPE) ? 1'b1 : 1'b0;
assign b_imm_sel= (opcode == I_TYPE) ? 1'b1:1'b0;
assign branch = (opcode == B_TYPE) ? 1'b1 : 1'b0;
assign wb_sel = (opcode == L_TYPE) ? 1'b1 : 1'b0;
assign jump = (opcode == J_TYPE) ? 1'b1 : 1'b0;

endmodule

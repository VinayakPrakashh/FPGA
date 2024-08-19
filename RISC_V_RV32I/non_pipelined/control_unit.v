`timescale 1ns / 1ps
module control_unit(opcode,funct3,funct7,imm_sel,alu_type_sel,b_imm_sel,branch,jump,memwrite_en,regwrite_en,wb_sel,alucontrol,alucontrol7);
//inputs
input [6:0] opcode;
input [2:0] funct3;
input [6:0] funct7;
//outputs
output [1:0] imm_sel,alu_type_sel;
output b_imm_sel,branch,jump,memwrite_en,regwrite_en,wb_sel;
output [2:0] alucontrol;
output [6:0] alucontrol7;

assign alucontrol = funct3;
assign alucontrol7 = funct7;
main_decoder main_decoder (.opcode(opcode), 
                           .imm_sel(imm_sel), 
                           .alu_type_sel(alu_type_sel), 
                           .b_imm_sel(b_imm_sel), 
                           .branch(branch), 
                           .jump(jump), 
                           .memwrite_en(memwrite_en), 
                           .regwrite_en(regwrite_en), 
                           .wb_sel(wb_sel));

endmodule
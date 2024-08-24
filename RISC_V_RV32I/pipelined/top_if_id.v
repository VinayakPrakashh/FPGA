`timescale 1ns / 1ps
module top_if_id2 (clk,rst,PC_sel,PCtarget,WB_ID_regwrite,WB_ID_WD,WB_ID_RDW_addr,ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_PC,ID_EX_RD,alu_type_sel,alucontrol,alucontrol7,b_imm_sel,branch,jump,memwrite_en,regwrite_en,wb_sel);


//inputs
input clk,rst;
input PC_sel,WB_ID_regwrite;
input [31:0] PCtarget;
input [31:0] WB_ID_WD;
input [4:0] WB_ID_RDW_addr;
//wire
wire [31:0] IF_ID_IR;
wire [31:0] IF_ID_PC;

//outputs
output [31:0] ID_EX_A, ID_EX_B,ID_EX_IMM,ID_EX_PC;
output [4:0] ID_EX_RD;
output [1:0] alu_type_sel;
output [2:0] alucontrol;
output [6:0] alucontrol7;
output b_imm_sel,branch,jump,memwrite_en,regwrite_en,wb_sel;
//instantiate
instruction_fetch instruction_fetch(.clk(clk),
                                    .rst(rst),
                                    .PCSrcE(PC_sel),
                                    .PCTargetE(PCtarget),
                                    .IF_ID_IR(IF_ID_IR),
                                    .IF_ID_PC(IF_ID_PC));
instruction_decode instruction_decode(.clk(clk),
                                      .rst(rst),
                                      .IF_ID_IR(IF_ID_IR),
                                      .IF_ID_PC(IF_ID_PC),
                                      .WB_ID_regwrite(WB_ID_regwrite),
                                      .WB_ID_WD(WB_ID_WD),
                                      .WB_ID_RDW_addr(WB_ID_RDW_addr),
                                      .ID_EX_A(ID_EX_A),
                                      .ID_EX_B(ID_EX_B),
                                      .ID_EX_IMM(ID_EX_IMM),
                                      .ID_EX_PC(ID_EX_PC),
                                      .ID_EX_RD(ID_EX_RD),
                                      .alu_type_sel(alu_type_sel),
                                      .alucontrol(alucontrol),
                                      .alucontrol7(alucontrol7),
                                      .b_imm_sel(b_imm_sel),
                                      .branch(branch),
                                      .jump(jump),
                                      .memwrite_en(memwrite_en),
                                      .regwrite_en(regwrite_en),
                                      .wb_sel(wb_sel));
endmodule

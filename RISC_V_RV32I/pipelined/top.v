`timescale 1ns / 1ps
module top(
clk,rst
    );
//inputs
input clk,rst;



//wire

//instantiate
instruction_fetch instruction_fetch(.clk(clk),
                                    .rst(rst),
                                    .PCSrcE(PCSrcE),
                                    .PCTargetE(PCTargetE),
                                    .IF_ID_IR(IF_ID_IR),
                                    .IF_ID_PC(IF_ID_PC),
                                    .IF_ID_PC1(IF_ID_PC1));

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
                                      .wb_sel(wb_sel)
                                      );
instruction_execution instruction_execution(.clk(clk),
                                          .rst(rst),
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
                                          .wb_sel(wb_sel),
                                          .EX_MEM_ALU_OUT(EX_MEM_ALU_OUT),
                                          .PCtarget(PCtarget),
                                          .PC_sel(PC_sel),
                                          .EX_MEM_memwrite_en(EX_MEM_memwrite_en),
                                          .EX_MEM_regwrite_en(EX_MEM_regwrite_en),
                                          .EX_MEM_wb_sel(EX_MEM_wb_sel),
                                          .EX_MEM_RD(EX_MEM_RD),
                                          .EX_MEM_writedata(EX_MEM_writedata)
                                          );

memory_access memory_access(.clk(clk),
                            .rst(rst),
                            .EX_MEM_ALU_OUT(EX_MEM_ALU_OUT),
                            .EX_MEM_writedata(EX_MEM_writedata),
                            .EX_MEM_RD(EX_MEM_RD),
                            .EX_MEM_memwrite_en(EX_MEM_memwrite_en),
                            .EX_MEM_regwrite_en(EX_MEM_regwrite_en),
                            .EX_MEM_wb_sel(EX_MEM_wb_sel),
                            .MEM_WB_RD(MEM_WB_RD),
                            .MEM_WB_regwrite_en(MEM_WB_regwrite_en),
                            .MEM_WB_wb_sel(MEM_WB_wb_sel),
                            .MEM_WB_ALU_OUT(MEM_WB_ALU_OUT),
                            .MEM_WB_LOAD_ALU_OUT(MEM_WB_LOAD_ALU_OUT)
                            );

write_back write_back(.clk(clk),
                      .rst(rst),
                      .MEM_WB_ALU_OUT(MEM_WB_ALU_OUT),
                      .MEM_WB_LOAD_ALU_OUT(MEM_WB_LOAD_ALU_OUT),
                      .MEM_WB_RD(MEM_WB_RD),
                      .MEM_WB_regwrite_en(MEM_WB_regwrite_en),
                      .MEM_WB_wb_sel(MEM_WB_wb_sel),
                      .WB_ID_WD3(WB_ID_WD3),
                      .WB_ID_RD_A3(WB_ID_RD_A3),
                      .WB_ID_WE3(WB_ID_WE3)
                      );
endmodule
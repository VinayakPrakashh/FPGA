`timescale 1ns / 1ps
module top(
clk,rst
    );
//inputs
input clk,rst;


//wire
wire [31:0] IF_ID_IR,IF_ID_PC; //IF_ID

wire [31:0] ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_PC,ID_EX_RD; //ID_EX
wire [2:0] alucontrol;//ID_EX
wire [6:0] alucontrol7;//ID_EX
wire [1:0] alu_type_sel,b_imm_sel;//ID_EX
wire branch,jump,memwrite_en,regwrite_en,wb_sel;//ID_EX

wire [31:0] EX_MEM_ALU_OUT,EX_MEM_writedata,PCtarget;//EX_MEM
wire [4:0] EX_MEM_RD;//EX_MEM
wire EX_MEM_memwrite_en,EX_MEM_regwrite_en;//EX_MEM
wire [1:0] EX_MEM_wb_sel;//EX_MEM

wire [31:0] MEM_WB_ALU_OUT,MEM_WB_LOAD_ALU_OUT;//MEM_WB
wire [4:0] MEM_WB_RD;//MEM_WB
wire MEM_WB_regwrite_en;//MEM_WB
wire [1:0] MEM_WB_wb_sel;//MEM_WB

wire [31:0] WB_ID_WD3;//WB_ID
wire [4:0] WB_ID_RD_A3;//WB_ID
wire WB_ID_WE3;//WB_ID


//instantiate
instruction_fetch instruction_fetch(.clk(clk),
                                    .rst(rst),
                                    .PCSrcE(PCSrcE),
                                    .PCTargetE(PCtarget),
                                    .IF_ID_IR(IF_ID_IR),
                                    .IF_ID_PC(IF_ID_PC));

instruction_decode instruction_decode(.clk(clk),
                                      .rst(rst),
                                      .IF_ID_IR(IF_ID_IR),
                                      .IF_ID_PC(IF_ID_PC),
                                      .WB_ID_regwrite(WB_ID_WE3),
                                      .WB_ID_WD(WB_ID_WD3),
                                      .WB_ID_RDW_addr(WB_ID_RD_A3),
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
                                          .PC_sel(PCSrcE),
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
module top_tb;

//inputs
reg clk;
reg rst;


//outputs


//instantiate
top top(.clk(clk),
        .rst(rst)
        );

//initial block
initial begin
    $monitor("IF_ID_IR=%h,IF_ID_PC=%h",top.IF_ID_IR,top.IF_ID_PC,top.ID_EX_A,top.ID_EX_B,top.ID_EX_IMM,top.ID_EX_PC,top.ID_EX_RD,top.EX_MEM_ALU_OUT,top.EX_MEM_writedata,top.PCtarget,top.EX_MEM_RD,top.EX_MEM_memwrite_en,top.EX_MEM_regwrite_en,top.EX_MEM_wb_sel,top.MEM_WB_ALU_OUT,top.MEM_WB_LOAD_ALU_OUT,top.MEM_WB_RD,top.MEM_WB_regwrite_en,top.MEM_WB_wb_sel,top.WB_ID_WD3,top.WB_ID_RD_A3,top.WB_ID_WE3);
    clk=0;
    rst=1;
    #10 rst=0;
    #1000 $finish;
end
//always block
always begin
    #5 clk=~clk;
end
endmodule
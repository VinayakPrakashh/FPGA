`timescale 1ns / 1ps
module instruction_execution (clk,rst,ID_EX_A, ID_EX_B,ID_EX_IMM,ID_EX_PC,ID_EX_RD,alu_type_sel,alucontrol,alucontrol7,b_imm_sel,branch,jump,memwrite_en,regwrite_en,wb_sel,EX_MEM_ALU_OUT,PCtarget,PC_sel,EX_MEM_memwrite_en,EX_MEM_regwrite_en,EX_MEM_wb_sel,EX_MEM_RD,EX_MEM_writedata);
//inputs
input clk,rst;
input [31:0] ID_EX_A, ID_EX_B,ID_EX_IMM,ID_EX_PC;
input [4:0] ID_EX_RD;
input [1:0] alu_type_sel;
input [2:0] alucontrol;
input [6:0] alucontrol7;
input b_imm_sel,branch,jump,memwrite_en,regwrite_en,wb_sel;
//outputs
output [31:0] EX_MEM_ALU_OUT,PCtarget,EX_MEM_writedata;
output PC_sel;
output [4:0] EX_MEM_RD;
output EX_MEM_memwrite_en,EX_MEM_regwrite_en,EX_MEM_wb_sel;

//registers
reg [31:0] EX_MEM_ALU_OUT_r,PCtarget_r,EX_MEM_writedata_r;
reg [4:0] EX_MEM_RD_r;
reg PC_sel_r;
reg EX_MEM_memwrite_en_r,EX_MEM_regwrite_en_r,EX_MEM_wb_sel_r;

//wire
wire branch_cond,branch_and;
wire [31:0] ID_EX_BI;
wire [31:0] EX_MEM_ALU_OUT_w,PCtarget_w,EX_MEM_writedata_w;
wire PC_sel_w;
wire EX_MEM_memwrite_en_w,EX_MEM_regwrite_en_w,EX_MEM_wb_sel_w;
wire [4:0] EX_MEM_RD_w;
//assign
assign EX_MEM_writedata_w = ID_EX_B;
assign EX_MEM_memwrite_en_w = memwrite_en;
assign EX_MEM_regwrite_en_w = regwrite_en;
assign EX_MEM_wb_sel_w = wb_sel;
assign EX_MEM_RD_w = ID_EX_RD;
assign PCtarget_w = ID_EX_PC + ID_EX_IMM;
assign branch_and = branch & branch_cond;
assign PC_sel_w = jump | branch_and;
//instantiate
alu alu (.ID_EX_A(ID_EX_A), 
         .ID_EX_BI(ID_EX_BI),
         .alu_type_sel(alu_type_sel),
         .alucontrol(alucontrol),
         .alucontrol7(alucontrol7),
         .EX_MEM_ALU_OUT(EX_MEM_ALU_OUT),
         .branch_cond(branch_cond));
 mux_2_1  mux2(.a(ID_EX_B),.b(ID_EX_IMM),.s(b_imm_sel),.y(ID_EX_BI));
always @(posedge clk or posedge rst)begin
    if(rst==1'b1)begin
        EX_MEM_ALU_OUT_r <= 32'b0;
        PCtarget_r <= 32'b0;
        PC_sel_r <= 1'b0;
        EX_MEM_memwrite_en_r <= 1'b0;
        EX_MEM_regwrite_en_r <= 1'b0;
        EX_MEM_wb_sel_r <= 1'b0;
        EX_MEM_RD_r <= 5'b0;
        EX_MEM_writedata_r <= 32'b0;
    end
    else begin
        EX_MEM_ALU_OUT_r <= EX_MEM_ALU_OUT_w;
        PCtarget_r <= PCtarget_w;
        PC_sel_r <= PC_sel_w;
        EX_MEM_memwrite_en_r <= EX_MEM_memwrite_en_w;
        EX_MEM_regwrite_en_r <= EX_MEM_regwrite_en_w;
        EX_MEM_wb_sel_r <= EX_MEM_wb_sel_w;
        EX_MEM_RD_r <= EX_MEM_RD_w;
        EX_MEM_writedata_r <= EX_MEM_writedata_w;
    end
end
assign EX_MEM_ALU_OUT = EX_MEM_ALU_OUT_r;
assign PCtarget = PCtarget_r;
assign PC_sel = PC_sel_r;
assign EX_MEM_memwrite_en = EX_MEM_memwrite_en_r;
assign EX_MEM_regwrite_en = EX_MEM_regwrite_en_r;
assign EX_MEM_wb_sel = EX_MEM_wb_sel_r;
assign EX_MEM_RD = EX_MEM_RD_r;
assign EX_MEM_writedata = EX_MEM_writedata_r;
endmodule

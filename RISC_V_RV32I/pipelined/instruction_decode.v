`timescale 1ns / 1ps
module instruction_decode(clk, rst, IF_ID_IR, IF_ID_PC,WB_ID_regwrite,WB_ID_WD,WB_ID_RDW_addr, ID_EX_A, ID_EX_B,ID_EX_IMM,ID_EX_PC,ID_EX_RD, alu_type_sel, alucontrol, alucontrol7, b_imm_sel,branch,jump,memwrite_en,regwrite_en,wb_sel);
// declaring the inputs
input clk, rst,WB_ID_regwrite;
input [31:0] IF_ID_IR, IF_ID_PC,WB_ID_WD;
input [4:0] WB_ID_RDW_addr;

//outputs
output [31:0] ID_EX_A, ID_EX_B,ID_EX_IMM,ID_EX_PC;
output [4:0] ID_EX_RD;
output [1:0] alu_type_sel;
output [2:0] alucontrol;
output [6:0] alucontrol7;
output b_imm_sel,branch,jump,memwrite_en,regwrite_en,wb_sel;


//registers
reg [31:0]  ID_EX_PC_r, ID_EX_A_r, ID_EX_B_r, ID_EX_IMM_r,ID_EX_RD_r;
reg [1:0] alu_type_sel_r;
reg [2:0] alucontrol_r;
reg [6:0] alucontrol7_r;
reg b_imm_sel_r,branch_r,jump_r,memwrite_en_r,regwrite_en_r,wb_sel_r; 

//internal wires
wire [31:0] ID_EX_PC_w, ID_EX_A_w, ID_EX_B_w, ID_EX_IMM_w,ID_EX_RD_w;
wire [1:0] alu_type_sel_w,imm_sel_w;
wire [2:0] alucontrol_w;
wire [6:0] alucontrol7_w;
wire b_imm_sel_w,branch_w,jump_w,memwrite_en_w,regwrite_en_w,wb_sel_w;

assign ID_EX_RD_w = IF_ID_IR[11:7];
//initiate the modules
Register_File reg1(.clk(clk),
                   .rst(rst), 
                   .WE3(WB_ID_regwrite),
                   .WD3(WB_ID_WD), 
                   .A1(IF_ID_IR[19:15]), 
                   .A2(IF_ID_IR[24:20]), 
                   .A3(WB_ID_RDW_addr), 
                   .RD1(ID_EX_A_w), 
                   .RD2(ID_EX_B_w)
                   );
control_unit control_unit(.opcode(IF_ID_IR[6:0]),
                          .funct3(IF_ID_IR[14:12]),
                          .funct7(IF_ID_IR[31:25]),
                          .imm_sel(imm_sel_w),
                          .alu_type_sel(alu_type_sel_w),
                          .b_imm_sel(b_imm_sel_w),
                          .branch(branch_w),
                          .jump(jump_w),
                          .memwrite_en(memwrite_en_w),
                          .regwrite_en(regwrite_en_w),
                          .wb_sel(wb_sel_w),
                          .alucontrol(alucontrol_w),
                          .alucontrol7(alucontrol7_w)
                          );
sign_extend sign_extend(.IR(IF_ID_IR),
                        .imm_sel(imm_sel_w),
                        .imm(ID_EX_IMM_w)
                        );

always @(posedge clk or posedge rst)begin
    if(rst == 1'b1)begin
        ID_EX_PC_r <= 32'b0;
        ID_EX_A_r <= 32'b0;
        ID_EX_B_r <= 32'b0;
        ID_EX_IMM_r <= 32'b0;
        ID_EX_RD_r <= 5'b0;
        alu_type_sel_r <= 2'b0;
        alucontrol_r <= 3'b0;
        alucontrol7_r <= 7'b0;
        b_imm_sel_r <= 1'b0;
        branch_r <= 1'b0;
        jump_r <= 1'b0;
        memwrite_en_r <= 1'b0;
        regwrite_en_r <= 1'b0;
        wb_sel_r <= 1'b0;

    end
    else begin
        ID_EX_PC_r <= IF_ID_PC;
        ID_EX_A_r <= ID_EX_A_w;
        ID_EX_B_r <= ID_EX_B_w;
        ID_EX_IMM_r <= ID_EX_IMM_w;
        ID_EX_RD_r <= ID_EX_RD_w;
        alu_type_sel_r <= alu_type_sel_w;
        alucontrol_r <= alucontrol_w;
        alucontrol7_r <= alucontrol7_w;
        b_imm_sel_r <= b_imm_sel_w;
        branch_r <= branch_w;
        jump_r <= jump_w;
        memwrite_en_r <= memwrite_en_w;
        regwrite_en_r <= regwrite_en_w;
        wb_sel_r <= wb_sel_w;
    end
end
assign ID_EX_PC = ID_EX_PC_r;
assign ID_EX_A = ID_EX_A_r;
assign ID_EX_B = ID_EX_B_r;
assign ID_EX_IMM = ID_EX_IMM_r;
assign ID_EX_RD = ID_EX_RD_r;
assign alu_type_sel = alu_type_sel_r;
assign alucontrol = alucontrol_r;
assign alucontrol7 = alucontrol7_r;
assign b_imm_sel = b_imm_sel_r;
assign branch = branch_r;
assign jump = jump_r;
assign memwrite_en = memwrite_en_r;
assign regwrite_en = regwrite_en_r;
assign wb_sel = wb_sel_r;

endmodule
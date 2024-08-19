module top (
    clk,rst,PCSrcE,PCtarget,ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_PC,ID_EX_RD,alucontrol,alucontrol7,alu_type_sel,b_imm_sel,branch,jump,memwrite_en,regwrite_en,wb_sel,WB_ID_WD3,WB_ID_RD_A3,WB_ID_WE3
);

//inputs
input clk,rst;
input PCSrcE;
input [31:0] PCtarget;
input [31:0] WB_ID_WD3;
input [4:0] WB_ID_RD_A3;
input WB_ID_WE3;
//outputs
output [31:0] ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_PC;
output [4:0] ID_EX_RD;
output [2:0] alucontrol;
output [6:0] alucontrol7;
output [1:0] alu_type_sel;
output b_imm_sel,branch,jump,memwrite_en,regwrite_en,wb_sel;


//internal wires
wire [31:0] IF_ID_IR;
wire [31:0] IF_ID_PC;


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
                                      .wb_sel(wb_sel));
endmodule
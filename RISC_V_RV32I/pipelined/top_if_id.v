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
output branch,jump,memwrite_en,regwrite_en,wb_sel,b_imm_sel;


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
module top_tb;

//inputs
reg clk,rst;
reg PCSrcE;
reg [31:0] PCtarget;
reg [31:0] WB_ID_WD3;
reg [4:0] WB_ID_RD_A3;
reg WB_ID_WE3;

//outputs
wire [31:0] ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_PC;
wire [4:0] ID_EX_RD;
wire [2:0] alucontrol;
wire [6:0] alucontrol7;
wire [1:0] alu_type_sel;
wire branch,jump,memwrite_en,regwrite_en,wb_sel,b_imm_sel;

//instantiate
top top(.clk(clk),
        .rst(rst),
        .PCSrcE(PCSrcE),
        .PCtarget(PCtarget),
        .ID_EX_A(ID_EX_A),
        .ID_EX_B(ID_EX_B),
        .ID_EX_IMM(ID_EX_IMM),
        .ID_EX_PC(ID_EX_PC),
        .ID_EX_RD(ID_EX_RD),
        .alucontrol(alucontrol),
        .alucontrol7(alucontrol7),
        .alu_type_sel(alu_type_sel),
        .branch(branch),
        .jump(jump),
        .memwrite_en(memwrite_en),
        .regwrite_en(regwrite_en),
        .wb_sel(wb_sel),
        .WB_ID_WD3(WB_ID_WD3),
        .WB_ID_RD_A3(WB_ID_RD_A3),
        .WB_ID_WE3(WB_ID_WE3));
initial begin
    clk=0;
    rst=0;
    PCSrcE=0;
    PCtarget=0;
    WB_ID_WD3=0;
    WB_ID_RD_A3=0;
    WB_ID_WE3=0;
    #10 rst=1;
    #10 rst=0;
    #10 PCSrcE=1;
    #10 PCtarget=32'h00000001;
    #10 WB_ID_WD3=32'h00000002;
    #10 WB_ID_RD_A3=5'b00010;
    #10 WB_ID_WE3=1;
    #10 $finish;
end
always begin
    #5 clk=~clk;
end
endmodule
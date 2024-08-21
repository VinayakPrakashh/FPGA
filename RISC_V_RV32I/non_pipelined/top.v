module top (clk,rst,WB_ID_WD3,WB_ID_RD_A3,WB_ID_WE3,MEM_WB_RD,MEM_WB_ALU_OUT,MEM_WB_LOAD_ALU_OUT,MEM_WB_regwrite_en,MEM_WB_wb_sel
);

//inputs
input clk,rst;


wire [31:0] WB_ID_WD3;
wire [4:0] WB_ID_RD_A3;
wire WB_ID_WE3;
//outputs
output [4:0] MEM_WB_RD;
output MEM_WB_regwrite_en,MEM_WB_wb_sel;
output [31:0] MEM_WB_ALU_OUT, MEM_WB_LOAD_ALU_OUT;


wire EX_MEM_wb_sel,EX_MEM_regwrite_en,EX_MEM_memwrite_en;
wire [31:0] EX_MEM_writedata,EX_MEM_ALU_OUT;
wire [4:0] EX_MEM_RD;

//outputs
wire PCSrcE;
wire [31:0] PCtarget;
wire [31:0] ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_PC;
wire [4:0] ID_EX_RD;
wire [2:0] alucontrol;
wire [6:0] alucontrol7;
wire [1:0] alu_type_sel;
wire b_imm_sel,branch,jump,memwrite_en,regwrite_en,wb_sel;


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
                                          .EX_MEM_writedata(EX_MEM_writedata));

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
                            .MEM_WB_LOAD_ALU_OUT(MEM_WB_LOAD_ALU_OUT));
write_back write_back(.clk(clk),
    .rst(rst),
    .MEM_WB_ALU_OUT(MEM_WB_ALU_OUT),
    .MEM_WB_LOAD_ALU_OUT(MEM_WB_LOAD_ALU_OUT),
    .MEM_WB_RD(MEM_WB_RD),
    .MEM_WB_regwrite_en(MEM_WB_regwrite_en),
    .MEM_WB_wb_sel(MEM_WB_wb_sel),
    .WB_ID_WD3(WB_ID_WD3),
    .WB_ID_RD_A3(WB_ID_RD_A3),
    .WB_ID_WE3(WB_ID_WE3));
endmodule
module write_back(    clk,
    rst,
    MEM_WB_ALU_OUT,
    MEM_WB_LOAD_ALU_OUT,
    MEM_WB_RD,
    MEM_WB_regwrite_en,
    MEM_WB_wb_sel,
    WB_ID_WD3,
    WB_ID_RD_A3,
    WB_ID_WE3);

//inputs
input clk,rst;
input [31:0] MEM_WB_ALU_OUT, MEM_WB_LOAD_ALU_OUT;
input [4:0] MEM_WB_RD;
input MEM_WB_regwrite_en;
input  MEM_WB_wb_sel;

//outputs
output [31:0] WB_ID_WD3;
output [4:0] WB_ID_RD_A3;
output WB_ID_WE3;

//registers
reg [31:0] WB_ID_WD3_r;
reg [4:0] WB_ID_RD_A3_r;
reg WB_ID_WE3_r;

//wire
wire WB_ID_WE3_w;
wire [31:0] WB_ID_WD3_w;
wire [4:0] WB_ID_RD_A3_w;
wire [4:0] MEM_WB_RD_w;
wire MEM_WB_regwrite_en_w;

// assign
assign MEM_WB_regwrite_en_w = MEM_WB_regwrite_en;
assign MEM_WB_RD_w = MEM_WB_RD;
//instantiate
mux_2_1 mux1(.a(MEM_WB_ALU_OUT),.b(MEM_WB_LOAD_ALU_OUT),.s(MEM_WB_wb_sel),.y(WB_ID_WD3_w));

always @(posedge clk or posedge rst)begin
    if(rst==1'b1)begin
        WB_ID_WD3_r <= 32'b0;
        WB_ID_RD_A3_r <= 5'b0;
        WB_ID_WE3_r <= 1'b0;
    end
    else begin
        WB_ID_WD3_r <= WB_ID_WD3_w;
        WB_ID_RD_A3_r <= MEM_WB_RD_w;
        WB_ID_WE3_r <= MEM_WB_regwrite_en_w;
    end
end
assign WB_ID_RD_A3=WB_ID_RD_A3_r;
assign WB_ID_WD3 = WB_ID_WD3_r;
assign WB_ID_WE3 = WB_ID_WE3_r;

endmodule
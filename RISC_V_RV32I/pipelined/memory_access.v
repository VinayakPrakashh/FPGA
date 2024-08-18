`timescale 1ns / 1ps
module memory_access (clk,rst,EX_MEM_ALU_OUT,EX_MEM_writedata,EX_MEM_RD,EX_MEM_memwrite_en,EX_MEM_regwrite_en,EX_MEM_wb_sel,MEM_WB_RD,MEM_WB_regwrite_en,MEM_WB_wb_sel,MEM_WB_ALU_OUT, MEM_WB_LOAD_ALU_OUT);

//inputs
input clk,rst;
input [31:0] EX_MEM_ALU_OUT,EX_MEM_writedata;
input [4:0] EX_MEM_RD;
input EX_MEM_memwrite_en,EX_MEM_regwrite_en;
input [1:0] EX_MEM_wb_sel;
//outputs
output [4:0] MEM_WB_RD;
output MEM_WB_regwrite_en;
output [1:0] MEM_WB_wb_sel;
output [31:0] MEM_WB_ALU_OUT, MEM_WB_LOAD_ALU_OUT;

//registers
reg [31:0] MEM_WB_ALU_OUT_r, MEM_WB_LOAD_ALU_OUT_r;
reg [4:0] MEM_WB_RD_r;
reg MEM_WB_regwrite_en_r;
reg [1:0] MEM_WB_wb_sel_r;

//wire
wire MEM_WB_regwrite_en_w;
wire [31:0] MEM_WB_ALU_OUT_w, MEM_WB_LOAD_ALU_OUT_w;
wire [4:0] MEM_WB_RD_w;
wire [1:0] MEM_WB_wb_sel_w;

//assign
assign MEM_WB_regwrite_en_w = EX_MEM_regwrite_en;
assign MEM_WB_wb_sel_w = EX_MEM_wb_sel;
assign MEM_WB_ALU_OUT_w = EX_MEM_ALU_OUT;
assign MEM_WB_RD_w = EX_MEM_RD;
//instantiation
data_memory data_memory (.clk(clk), 
                         .rst(rst), 
                         .WE(EX_MEM_memwrite_en), 
                         .WD(EX_MEM_writedata), 
                         .A(EX_MEM_ALU_OUT), 
                         .RD(MEM_WB_LOAD_ALU_OUT_w));

always @(posedge clk or posedge rst)begin
    if(rst==1'b1)begin
        MEM_WB_ALU_OUT_r <= 32'b0;
        MEM_WB_LOAD_ALU_OUT_r <= 32'b0;
        MEM_WB_RD_r <= 5'b0;
        MEM_WB_regwrite_en_r <= 1'b0;
        MEM_WB_wb_sel_r <= 2'b0;
    end
    else begin
        MEM_WB_ALU_OUT_r <= MEM_WB_ALU_OUT_w;
        MEM_WB_LOAD_ALU_OUT_r <= MEM_WB_LOAD_ALU_OUT_w;
        MEM_WB_RD_r <= MEM_WB_RD_w;
        MEM_WB_regwrite_en_r <= MEM_WB_regwrite_en_w;
        MEM_WB_wb_sel_r <= MEM_WB_wb_sel_w;
    end
end
assign MEM_WB_RD = MEM_WB_RD_r;
assign MEM_WB_regwrite_en = MEM_WB_regwrite_en_r;
assign MEM_WB_wb_sel = MEM_WB_wb_sel_r;
assign MEM_WB_ALU_OUT = MEM_WB_ALU_OUT_r;
assign MEM_WB_LOAD_ALU_OUT = MEM_WB_LOAD_ALU_OUT_r;
endmodule

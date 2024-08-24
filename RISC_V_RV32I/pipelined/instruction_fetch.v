
`timescale 1ns / 1ps
module instruction_fetch (clk, rst, PCSrcE, PCTarget, IF_ID_IR, IF_ID_PC);
    //  input & outputs
    input clk, rst;
    input PCSrcE;
    input [31:0] PCTarget;
    output [31:0] IF_ID_IR;
    output [31:0] IF_ID_PC;

    // internal wires
    wire [31:0] PC_F, PCF, PCPlus1F;
    wire [31:0] InstrF;

    // Declaration of Register
    reg [31:0] IF_ID_IR_reg;
    reg [31:0] IF_ID_PC_reg;
pc PC (.clk(clk), .rst(rst), .PC(PCF), .PC_Next(PC_F));
Instruction_mem Instruction_mem (.rst(rst), .A(PCF), .RD(InstrF));
PC_adder PC_adder (.a(PCF), .c(PCPlus1F));
mux_2_1 PC_mux (.a(PCPlus1F), .b(PCTarget), .s(PCSrcE), .y(PC_F));

always @(posedge clk or posedge rst)begin
    if(rst==1'b1)
    begin
        IF_ID_IR_reg <= 32'h00000000;
        IF_ID_PC_reg <= 32'h00000000;
    end
    else
    begin
        IF_ID_IR_reg <= InstrF;
        IF_ID_PC_reg<= PCF;
    end
end
assign IF_ID_IR =IF_ID_IR_reg;
assign IF_ID_PC =IF_ID_PC_reg;
endmodule

`timescale 1ns / 1ps
module write_back (
    MEM_WB_PC,
    MEM_WB_IR,
    MEM_WB_ALU_OUT,
    WB_IF_PC
);
 parameter R_TYPE = 7'b0110011, I_TYPE = 7'b0010011, J_TYPE = 7'b1101111,LUI=7'b0110111, AUIPC=7'b0010111, JAL=7'b1101111, JALR=7'b1100111;
    input [31:0] MEM_WB_PC;
    input [31:0] MEM_WB_IR;
    input [31:0] MEM_WB_ALU_OUT;
    output [31:0] WB_IF_PC;
    assign WB_IF_PC = MEM_WB_PC;
    reg WR_EN;

    reg_file reg_file2(
    .WE(WR_EN),
    .WR1(MEM_WB_ALU_OUT),
    .RE(0),
    .RW_addr(MEM_WB_IR[11:7])
);
always @(*) begin
    case (MEM_WB_IR[6:0])
        R_TYPE,I_TYPE,J_TYPE,LUI,AUIPC,JAL,JALR: WR_EN <=1;
        default: WR_EN <= 0;
    endcase

   end
endmodule
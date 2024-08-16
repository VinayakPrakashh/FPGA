`timescale 1ns / 1ps

module Memory_access(
EX_MEM_PC,EX_MEM_IR,EX_MEM_ALU_OUT,MEM_WB_PC,MEM_WB_IR,MEM_WB_ALU_OUT
    );
    input [31:0] EX_MEM_PC,EX_MEM_IR,EX_MEM_ALU_OUT;
    output [31:0] MEM_WB_PC,MEM_WB_IR,MEM_WB_ALU_OUT;
    assign MEM_WB_PC =EX_MEM_PC;
    assign MEM_WB_IR=EX_MEM_IR;
    assign MEM_WB_ALU_OUT = EX_MEM_ALU_OUT;
    wire [31:0] mem_out;
    reg REG_WR_EN,REG_RD_EN,DATA_WR_EN;
    parameter L_TYPE = 7'b0000001, S_TYPE = 7'b0100011;
    wire [31:0] reg_data;
reg_file reg_file1(
    .WE(REG_WR_EN),
    .RE(REG_RD_EN),
    .RW_addr(EX_MEM_IR[24:20]),
    .RD1_addr(EX_MEM_IR[11:7]),
    .WR1(mem_out),
    .RD2(reg_data)
);
data_memory data_memory1(
    .addr(EX_MEM_ALU_OUT),
    .RD(mem_out),
    .wr_en(DATA_WR_EN),
    .WD(reg_data)
);

always @(*) begin
    
case(EX_MEM_IR[6:0])    
    L_TYPE:begin
        REG_WR_EN <= 1; REG_RD_EN <= 0; DATA_WR_EN <= 0;
    end
    S_TYPE:begin
        REG_WR_EN <= 0; REG_RD_EN <= 1; DATA_WR_EN <= 1;
    end
    default:begin
        REG_WR_EN <= 0; REG_RD_EN <= 0; DATA_WR_EN <= 0;
    end

endcase
end
endmodule

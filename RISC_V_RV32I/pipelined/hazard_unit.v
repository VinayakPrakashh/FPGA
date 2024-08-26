module hazard_unit(rst,EX_MEM_regwrite_en,MEM_WB_regwrite_en,EX_MEM_rd,MEM_WB_rd,ID_rs1,ID_rs2,ID_EX_rd,forwardAE,forwardBE);
input rst,EX_MEM_regwrite_en,MEM_WB_regwrite_en;
input [4:0] EX_MEM_rd,MEM_WB_rd,ID_rs1,ID_rs2,ID_EX_rd;

output forwardAE,forwardBE;

assign forwardAE = (rst ==1'b1)? 2'b00:
                   (((EX_MEM_regwrite_en == 1) & (EX_MEM_rd!=5'b00000)) &(EX_MEM_rd == ID_rs1))? 2'b10 :
                   (((MEM_WB_regwrite_en == 1) & (MEM_WB_rd!=5'b00000)) &(MEM_WB_rd == ID_rs1))? 2'b01 : 2'b00;
assign forwardBE = (rst ==1'b1)? 2'b00:
                   (((EX_MEM_regwrite_en == 1) & (EX_MEM_rd!=5'b00000)) &(EX_MEM_rd == ID_rs2))? 2'b10 :
                   (((MEM_WB_regwrite_en == 1) & (MEM_WB_rd!=5'b00000)) &(MEM_WB_rd == ID_rs2))? 2'b01 : 2'b00;
endmodule
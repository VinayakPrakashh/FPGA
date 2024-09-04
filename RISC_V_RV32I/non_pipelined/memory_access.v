`timescale 1ns / 1ps

module Memory_access(
EX_MEM_PC,EX_MEM_IR,EX_MEM_ALU_OUT,MEM_WB_PC,MEM_WB_IR,MEM_WB_ALU_OUT
    );
    input [31:0] EX_MEM_PC,EX_MEM_IR,EX_MEM_ALU_OUT;
    output [31:0] MEM_WB_PC,MEM_WB_IR,MEM_WB_ALU_OUT;
    assign MEM_WB_PC =EX_MEM_PC;
    assign MEM_WB_IR=EX_MEM_IR;
    assign MEM_WB_ALU_OUT = EX_MEM_ALU_OUT;
    wire [31:0] mem_out_data;
    reg [31:0] mem_out;
    wire [31:0] reg_data_n;
    reg REG_WR_EN,REG_RD_EN,DATA_WR_EN;
    parameter L_TYPE = 7'b0000011, S_TYPE = 7'b0100011;
    parameter LB = 3'b000, LH = 3'b001, LW = 3'b010, LBU = 3'b100, LHU = 3'b101;
    parameter SB=3'b000, SH=3'b001, SW=3'b010;
    reg [31:0] reg_data;
reg_file reg_file1(
    .WE(REG_WR_EN),
    .RE(REG_RD_EN),
    .RW_addr(EX_MEM_IR[11:7]),
    .RD1_addr(EX_MEM_IR[24:20]),
    .WR1(mem_out),
    .RD2(reg_data_n)
);
data_memory data_memory1(
    .addr(EX_MEM_ALU_OUT),
    .RD(mem_out_data),
    .wr_en(DATA_WR_EN),
    .WD(reg_data)
);
always @(*) begin
    
case(EX_MEM_IR[6:0])    
    L_TYPE:begin
    REG_WR_EN <= 1; REG_RD_EN <= 0; DATA_WR_EN <= 0;
     
        case(EX_MEM_IR[14:12])
            LB:begin
               mem_out <= {mem_out_data[7:0],{24{1'b0}}};
            end
            LH:begin
             mem_out <= {mem_out_data[15:0],{16{1'b0}}};
            end
            LW:begin
          mem_out <= mem_out_data;
            end
            LBU:begin
             mem_out <= {mem_out_data[7:0],{24{1'b0}}};
            end
            LHU:begin
                mem_out <= {mem_out_data[15:0],{16{1'b0}}};
            end
        endcase  
        
    end
    S_TYPE:begin
       REG_WR_EN <= 0; REG_RD_EN <= 1; DATA_WR_EN <= 1;
        case(EX_MEM_IR[14:12])
            SB:begin
                reg_data <= {reg_data_n[7:0],{24{1'b0}}};
            end
            SH:begin
               reg_data <= {reg_data_n[15:0],{16{1'b0}}};
            end
            SW:begin
                reg_data <= reg_data_n;
            end
        endcase
     
    end
    default:begin
        REG_WR_EN <= 0; REG_RD_EN <= 0; DATA_WR_EN <= 0;
    end

endcase
end
endmodule
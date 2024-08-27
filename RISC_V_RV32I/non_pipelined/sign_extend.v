`timescale 1ns / 1ps
module sign_extend(IR,IMM);
//inputs
input [31:0] IR;

output reg [31:0] IMM;
parameter I_TYPE = 7'b0010011, B_TYPE = 7'b1100011, L_TYPE = 7'b0000011, S_TYPE = 7'b0100011, LUI=7'b0110111, AUIPC=7'b0010111, JAL=7'b1101111, JALR=7'b1100111;
always @(*) begin
    case(IR[6:0])
    I_TYPE: IMM <= {{20{IR[31]}},IR[31:20]};
    L_TYPE: IMM <= {{20{1'b0}},IR[31:20]};
    S_TYPE: IMM <= {{20{1'b0}},IR[31:25],IR[11:7]};
    B_TYPE: IMM <= {{19{1'b0}},IR[31:25],IR[11:7]};
    JAL   : IMM <= {{12{1'b0}},IR[31:12]};
    JALR  : IMM <= {{20{1'b0}},IR[31:20]};
    LUI   : IMM <= {IR[31:12],12'b0};
    AUIPC : IMM <= {IR[31:12],12'b0};   
    default: begin
        IMM <= 0;
    end 
endcase
end
endmodule
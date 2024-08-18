module Main_Decoder(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,ALUOp);
    input [6:0]Op;
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
    output [1:0]ImmSrc,ALUOp;
parameter R_TYPE = 7'b0110011, I_TYPE = 7'b0010011, B_TYPE = 7'b1100011, L_TYPE = 7'b0000011, S_TYPE = 7'b0100011;
    assign RegWrite = (Op == L_TYPE | Op == R_TYPE | Op == I_TYPE ) ? 1'b1 :
                                                              1'b0 ;
    assign ImmSrc = (Op == S_TYPE) ? 2'b01 : 
                    (Op == B_TYPE) ? 2'b10 :    
                                         2'b00 ;
    assign ALUSrc = (Op == L_TYPE | Op == S_TYPE | Op == I_TYPE) ? 1'b1 :
                                                            1'b0 ;
    assign MemWrite = (Op == S_TYPE) ? 1'b1 :
                                           1'b0 ;
    assign ResultSrc = (Op == L_TYPE) ? 1'b1 :
                                            1'b0 ;
    assign Branch = (Op == B_TYPE) ? 1'b1 :
                                         1'b0 ;
    assign ALUOp = (Op == R_TYPE) ? 2'b10 :
                   (Op == B_TYPE) ? 2'b01 :
                                        2'b00 ;

endmodule
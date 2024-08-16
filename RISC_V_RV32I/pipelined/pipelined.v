`timescale 1ns / 1ps
module risc_v_rv32i(clk1,clk2,start
    );
    input clk1,clk2,start;
    reg HALTED,TAKEN_BRANCH;
    reg [31:0] EX_MEM_IR,EX_MEM_ALUout;
    reg [31:0] ID_EX_IR,ID_EX_A,ID_EX_B,ID_EX_NPC,ID_EX_IMM;
    reg [31:0] EX_MEM_ALUout,EX_MEM_B,EX_MEM_IR,EX_MEM_NPC,EX_MEM_IMM;
    reg [9:0] PC;
    reg [2:0] ID_EX_TYPE,EX_MEM_TYPE,MEM_WB_TYPE;
    reg [31:0] MEM_WB_ALUout,MEM_WB_B,MEM_WB_IR,MEM_WB_NPC,MEM_WB_IMM;
    reg [31:0] IF_ID_IR,IF_ID_NPC;
    reg [31:0] mem [0:1023];
    reg [31:0] Reg [0:31];
    parameter HLT=7'b1010101, R_TYPE = 7'b0110011, I_TYPE = 7'b0010011, B_TYPE = 7'b1100011, L_TYPE = 7'b0000001, S_TYPE = 7'b0100011, J_TYPE = 7'b1101111 ;
    parameter ADD = 3'b000, SUB = 3'b001, AND = 3'b010, OR = 3'B011, XOR = 3'B100, SLL = 3'b101,SRL = 3'b110;
    parameter BEQ = 3'B000, BNE = 3'B001, BLT = 3'B010, BGT = 3'B011;
    parameter LB = 3'b000, LH = 3'b001, LW = 3'b010;
    parameter SB = 3'b000, SH = 3'b001, SW = 3'b010;
    always @(posedge start)
    begin
    PC = 0;
    TAKEN_BRANCH = 1'b0;
    HALTED = 1'b0;
//    mem[000] = 32'hAFEDFFFF;
    end
    always @(posedge clk1) //Instruction fetch
    begin
    if(HALTED == 0) begin
    
    if(TAKEN_BRANCH)begin
    IF_ID_IR <= mem[EX_MEM_ALUout];
    IF_ID_NPC <= EX_MEM_ALUout+1;
    PC <= EX_MEM_ALUout+1;
    TAKEN_BRANCH <= 1'b0;
    end
    else begin
    IF_ID_IR <= mem[PC];
    IF_ID_NPC <= PC+1;
    PC <= PC+1;
    end
    end
    end

    always @(posedge clk2) //Instruction decode
    begin
    if(HALTED == 0) begin
        ID_EX_NPC <= IF_ID_NPC;
        ID_EX_IR <= IF_ID_IR;
        if(IF_ID_IR[19:15]== 5'b00000) ID_EX_A <= 0;
        else ID_EX_A <= Reg[IF_ID_IR[19:15]];
        if(IF_ID_IR[24:20]== 5'b00000) ID_EX_B <= 0;
        else ID_EX_B <= Reg[IF_ID_IR[24:20]];
        case (IF_ID_IR[6:0])
            I_TYPE:  if(IF_ID_IR[14:12]==SLL | IF_ID_IR[14:12]==SRL)ID_EX_IMM <= {{24{IF_ID_IR[31]}},IF_ID_IR[31:25]};
                     else ID_EX_IMM <= {{19{IF_ID_IR[31]}},IF_ID_IR[31:20]};
            B_TYPE:  ID_EX_IMM <= {{19{IF_ID_IR[31]}},IF_ID_IR[31],IF_ID_IR[7],IF_ID_IR[30:25],IF_ID_IR[11:8]};
            L_TYPE:  ID_EX_IMM <= {{19{IF_ID_IR[31]}},IF_ID_IR[31:20]};
            S_TYPE:  ID_EX_IMM <= {{19{IF_ID_IR[31]}},IF_ID_IR[31:25],IF_ID_IR[11:7]};
            J_TYPE:  ID_EX_IMM <= {{11{IF_ID_IR[31]}},IF_ID_IR[31],IF_ID_IR[19:12],IF_ID_IR[20],IF_ID_IR[30:21]};
            HLT: HALTED<=1'b1;
            default: ID_EX_IMM <= 0;
        endcase
        ID_EX_TYPE <= IF_ID_IR[6:0];
    end
    end
    always @(posedge clk1)//instruction execute
    begin
    if(HALTED == 0) begin
        TAKEN_BRANCH = 0; 
        EX_MEM_IR <= ID_EX_IR;
        EX_MEM_TYPE <= ID_EX_TYPE;
        case (ID_EX_TYPE)
            R_TYPE:  case (ID_EX_IR[14:12])
                        ADD: EX_MEM_ALUout <= ID_EX_A + ID_EX_B;
                        SUB: EX_MEM_ALUout <= ID_EX_A - ID_EX_B;
                        AND: EX_MEM_ALUout <= ID_EX_A & ID_EX_B;
                        OR: EX_MEM_ALUout <= ID_EX_A | ID_EX_B;
                        XOR: EX_MEM_ALUout <= ID_EX_A ^ ID_EX_B;
                        SLL: EX_MEM_ALUout <= ID_EX_A << ID_EX_B;
                        SRL: EX_MEM_ALUout <= ID_EX_A >> ID_EX_B;

                        endcase
            I_TYPE: case (ID_EX_IR[14:12])
                        ADD: EX_MEM_ALUout <= ID_EX_A + ID_EX_IMM;
                        SUB: EX_MEM_ALUout <= ID_EX_A - ID_EX_IMM;
                        AND: EX_MEM_ALUout <= ID_EX_A & ID_EX_IMM;
                        OR: EX_MEM_ALUout <= ID_EX_A | ID_EX_IMM;
                        XOR: EX_MEM_ALUout <= ID_EX_A ^ ID_EX_IMM;
                        SLL: EX_MEM_ALUout <= ID_EX_A << ID_EX_IR[24:20];
                        SRL: EX_MEM_ALUout <= ID_EX_A >> ID_EX_IR[24:20];
                        endcase
            B_TYPE: case (ID_EX_IR[14:12])
                        BEQ: if(ID_EX_A == ID_EX_B) begin EX_MEM_ALUout <= ID_EX_NPC + ID_EX_IMM; TAKEN_BRANCH <= 1; end
                        BNE: if(ID_EX_A != ID_EX_B) begin EX_MEM_ALUout <= ID_EX_NPC + ID_EX_IMM; TAKEN_BRANCH <= 1; end
                        BLT: if(ID_EX_A < ID_EX_B) begin EX_MEM_ALUout <= ID_EX_NPC + ID_EX_IMM; TAKEN_BRANCH <= 1; end
                        BGT: if(ID_EX_A > ID_EX_B) begin EX_MEM_ALUout <= ID_EX_NPC + ID_EX_IMM; TAKEN_BRANCH <= 1; end
                        endcase
            L_TYPE: case (ID_EX_IR[14:12])
                        LB: EX_MEM_ALUout <= mem[ID_EX_A + ID_EX_IMM];
                        LH: EX_MEM_ALUout <= mem[ID_EX_A + ID_EX_IMM];
                        LW: EX_MEM_ALUout <= mem[ID_EX_A + ID_EX_IMM];
                        endcase
            S_TYPE: case (ID_EX_IR[14:12])
                        SB: mem[ID_EX_A + ID_EX_IMM] <= ID_EX_B;
                        SH: mem[ID_EX_A + ID_EX_IMM] <= ID_EX_B;
                        SW: mem[ID_EX_A + ID_EX_IMM] <= ID_EX_B;
                        endcase
            J_TYPE: begin EX_MEM_ALUout <= ID_EX_NPC + ID_EX_IMM; TAKEN_BRANCH <= 1; end
            default: EX_MEM_ALUout <= 0;
        endcase

    end
    end
    always @(posedge clk2) //Memory access
     begin
        if(HALTED == 0) begin
            MEM_WB_TYPE <= EX_MEM_TYPE;
            MEM_WB_IR <= EX_MEM_IR;
            case (EX_MEM_TYPE)
                R_TYPE, I_TYPE: MEM_WB_ALUout <= EX_MEM_ALUout;
                L_TYPE: MEM_WB_ALUout <= mem[EX_MEM_ALUout];          
                S_TYPE: if(TAKEN_BRANCH == 0) MEM_WB_ALUout <= EX_MEM_ALUout; 
                
                default: MEM_WB_ALUout <= 0;  
            endcase
        end
    end
    always @(posedge clk1) //Write back
    begin
        if(HALTED == 0) begin
            case (MEM_WB_TYPE)
                R_TYPE: Reg[MEM_WB_IR[11:7]] <= MEM_WB_ALUout;
                I_TYPE: Reg[MEM_WB_IR[11:7]] <= MEM_WB_ALUout;
                L_TYPE: Reg[MEM_WB_IR[11:7]] <= MEM_WB_ALUout;
                S_TYPE: if(TAKEN_BRANCH == 0) Reg[MEM_WB_IR[11:7]] <= MEM_WB_ALUout;
                default: Reg[MEM_WB_IR[11:7]] <= 0;
            endcase
        end
    end
endmodule

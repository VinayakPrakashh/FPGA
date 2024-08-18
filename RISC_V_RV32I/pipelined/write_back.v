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
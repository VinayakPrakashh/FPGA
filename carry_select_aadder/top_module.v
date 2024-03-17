module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [1:0] d;
    wire sel;
    wire [31:0] sum1;
    add16 int1(a[15:0],b[15:0],0,sum[15:0],sel);
    add16 int2(a[31:16],b[31:16],0,sum1[15:0],d[0]);
    add16 int3(a[31:16],b[31:16],1,sum1[31:16],d[1]);
    mux int4(sum1,sel,sum[31:16]);
    
endmodule
module mux(d, sel, y);
    input [31:0] d;
    input sel;
    output reg [15:0] y;
    always @(*) begin
    case (sel)
        1'b0: y = d[15:0];
        1'b1: y = d[31:16];
        default: y = 16'b0; // Handle the default case
    endcase
    end
endmodule
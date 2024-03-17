module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    
    output [31:0] sum
);
    wire[31:0]  bout;
    wire cout1,cout2;
    xormux int2(b[31:0],sub,bout);
    add16 int3(a[15:0],bout[15:0],sub,sum[15:0],cout1);
    add16 int4(a[31:16],bout[31:16],cout1,sum[31:16]);
endmodule
module xormux(d0,sel,y);
input [31:0] d0;
input sel;
output reg [31:0] y;
always @(*) begin
case(sel)
1'b0: y  = d0;
1'b1: y = ~d0;
endcase
end

endmodule
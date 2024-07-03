`timescale 1ns / 1ps
module data_path(gt,lt,eq,ldA,ldB,sel1,sel2,sel_in,data_in,clk,gcd_out

    );
    input [15:0] data_in;
    input ldA,ldB,sel1,sel2,sel_in,clk;
    output lt,gt,eq;
    output [15:0] gcd_out;
    wire [15:0] Aout,Bout,X,Y,bus,Sout;
    assign gcd_out = (Aout == Bout)?Aout:0;
    PIPO A(Aout,bus,ldA,clk);
    PIPO B(Bout,bus,ldB,clk);
    MUX m1(X,Aout,Bout,sel1);
    MUX m2(Y,Aout,Bout,sel2);
    MUX mux_in(bus,Sout,data_in,sel_in);
    SUB sb(Sout,X,Y);
    COMPARE CP(lt,gt,eq,Aout,Bout);
    
endmodule
module PIPO(data_out,data_in,load,clk);
input [15:0] data_in;
output reg [15:0] data_out;
input clk,load;
always @(posedge clk)
begin
if(load) data_out <= data_in;
end
endmodule
module MUX(out,in1,in2,sel,clk);
input [15:0] in1,in2;
output  [15:0] out;
input clk,sel;
assign out = sel?in2:in1;
endmodule 
module COMPARE(lt,gt,eq,in1,in2);
input [15:0] in1,in2;
output lt,gt,eq;
assign lt = (in1 < in2);
assign gt = (in1 > in2);
assign eq = (in1 == in2);
endmodule
module SUB(out,in1,in2);
input [15:0] in1,in2;
output reg [15:0] out;
always @(*)
out = in1 - in2;
endmodule
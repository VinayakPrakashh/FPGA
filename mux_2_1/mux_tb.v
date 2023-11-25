`timescale 1ns / 1ps
module mux_tb();
reg i[3:0],a;
wire r;

_2_1_mux  dut(.D1(i[1]),.D0(i[0]),.S(a),.Y(r));

initial begin
i[1] = 0;
i[0] = 0;
a = 0;
#5
i[0] = 1;
#5
i[1] = 0;
i[0] = 0;
a = 1;
#5
i[1]= 1;
end

initial begin
       $display("D1  D0  S  Y");
       $monitor("%b  %b  %b  %b",i[1],i[0],a,r);
       #30
       $finish;
end
endmodule

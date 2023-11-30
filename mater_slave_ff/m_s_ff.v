`timescale 1ns / 1ps
module m_s_ff(
    input j,k,clk,rst,
    output reg q,qn
    );
    reg internal_q;
    
always @(posedge clk) begin
if(rst) begin
q <= 0;
internal_q <= 0;
end else begin
if(j && !k) begin
internal_q <= 1;
end else if(!j && k) begin
internal_q <= 0;
end else begin
internal_q <= internal_q;
end
end
end  
always @(posedge clk) begin
    q <= internal_q;
    qn <= ~internal_q;
  end
endmodule

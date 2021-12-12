`timescale 1ns / 1ps
module segment(input [2:0] state ,output reg [6:0] segout);
always @(state)
    begin
case(state)
  3'b100: segout= 7'b1000_001;
  default: segout= 7'b1110_001;
   endcase
   end
endmodule

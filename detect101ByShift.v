`timescale 1ns / 1ps

module detect101ByShift(input clk, rst, x, output reg [2:0] z);
shiftRegister det101( clk, rst, x, z);

endmodule

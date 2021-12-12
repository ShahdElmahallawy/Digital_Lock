module shiftRegister(input clk, rst, in, output reg [2:0]out, output finalOut);
always@ (posedge clk)
begin 
if (rst)
out <=0;
else 
out<= {in, out[2], out[1]};
end 
assign finalOut = (out == 3'b101);
endmodule

module fsm(input clk, rst, x, output reg z);
reg [1:0] state, nextState;
parameter [1:0] A=2'b00, B=2'b01, C=2'b10;
always @(x or state) 
begin
 case (state)
 A:
 if(x) 
     begin
      nextState=B;
      z = 0;
     end
 else
     begin
      nextState=A;
      z=0;
     end
 B: 
    if(x) 
    begin
    nextState=B;
    z=0; 
    end
else
     begin 
     nextState=C;
     z=0;
     end
 C: 
 if(x)
     begin
     nextState=B;
     z=1;
     end
 else
     begin
      nextState=A;
      z=0;
     end
 endcase
 end
 
always@(posedge clk)
 begin
 if(!rst)
    state<=A;
 else
    state<=nextState;
end

endmodule

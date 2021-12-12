
module digital_lock(input A, B, C, D, rst, clk, output [6:0]out);

wire a1,  b1, c1, d1;
wire a2, b2, c2, d2;
reg [2:0] state, nextState;

//states
parameter [2:0] s0= 3'b000
, s1= 3'b001
, s2= 3'b010
, s3= 3'b011
, s4= 3'b100;

//sychronizer and debouncer 
//module debouncer(input clk, inp, output out);
debouncer debouncer1 (clk,A, a1);
debouncer debouncer2 (clk,B, b1);
debouncer debouncer3 (clk,C, c1);
debouncer debouncer4 (clk,D, d1);
//risig edge 
//module risingedge(input clk, rst, level, output reg z);
risingedge rsingedge1 (clk, rst, a1, a2);
risingedge rsingedge2 (clk, rst,  b1, b2);
risingedge rsingedge3 (clk, rst, c1, c2);
risingedge rsingedge4 (clk, rst, d1, d2);

//FSM 
always @(state or a2 or b2 or c2 or d2) 
begin
 case (state)
 s0:
 if(a2) 
     begin
      nextState=s1;
     end
else if (!a2 && !b2 && !c2 && !d2)
    begin 
    nextState=s0;
    end
 else
     begin
      nextState=s0;
     end
 s1: 
if(b2) 
    begin
    nextState=s2;
    end
else if(a2)
    begin
    nextState=s1;
    end
else if (!a2 && !b2)
    begin
    nextState=s0;
    end
else if(!a2 && !b2 && !c2 && !d2)
     begin 
     nextState=s1;
     end
 s2: 
if(c2)
     begin
     nextState=s3;
     end
else if (a2)
    begin
    nextState=s1;
    end
else if (!a2 && !c2)
        begin
        nextState=s0;
        end  
 else if (!a2 && !b2 && !c2 && !d2)
     begin
      nextState=s2;
     end
 s3: 
    if(d2)
         begin
         nextState=s4;
         end
    else if (a2)
        begin
        nextState=s1;
        end
    else if (!a2 && !d2)
            begin
            nextState=s0;
            end  
     else if (!a2 && !b2 && !c2 && !d2)
         begin
          nextState=s3;
         end
 s4:
 begin 
 nextState<= state;
 end
 endcase
 end

//check reset
always@(posedge clk)
begin
 if(rst)
    state<=s0;
 else
    state<=nextState;
end
 //get the output from segment
//module segment(input [2:0] state ,output reg [6:0] segout);
segment seg(state, out);
endmodule

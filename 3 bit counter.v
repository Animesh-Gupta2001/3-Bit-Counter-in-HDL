`timescale 1ns / 1ps
//module to count from 0->2->4->6->0 if countup==1, 6->4->2->0->6 if countup==0
module CountFSM (output reg [3:0] current_state,
input clock, input reset, input count_up);
reg div_clk;
reg [26:0] delay_count;
reg [3:0]s0 = 4'b0000;
reg [3:0]s1 = 4'b0010;
reg [3:0]s2 = 4'b0100;
reg [3:0]s3 = 4'b0110;

always @(posedge clock or posedge reset) //code to decrease frequency of clock
begin 
if(reset)
begin 
delay_count <=27'd0;
div_clk <= 1'b0;
end 
else
if(delay_count==27'd67108863)  //maxiumum value is 2^27 - 1
begin
delay_count<=27'd0;
div_clk <= ~div_clk;
end
else delay_count <= delay_count+1;
end

always @(posedge div_clk or posedge reset) //module to assign change of states
begin
if(reset) current_state <=s0;
else if(count_up)
begin 
case(current_state)
4'b0000: current_state <= s1;
4'b0010: current_state <= s2;
4'b0100: current_state <= s3;
4'b0110: current_state <= s0;
default: current_state <=s0;
endcase
end
else if(count_up==0)
begin case(current_state)
4'b0000: current_state <= s3;
4'b0010: current_state <= s0;
4'b0100: current_state <= s1;
4'b0110: current_state <= s2;
default: current_state <=s0;
endcase
end
end
endmodule


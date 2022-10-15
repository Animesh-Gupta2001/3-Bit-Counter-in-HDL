`timescale 1ns / 1ps
//module to test the 3 bit counter
module CountFSM_tb();
reg clock,reset,count_up;
wire [3:0]current_state;

CountFSM c1(current_state,clock,reset,count_up); //instantiation of module

initial begin //code to setup up clock
clock=1'b0;
repeat(32)
begin
#5 clock=~clock;
end
$finish;
end

initial begin //test cases
reset=0; count_up=1;
#2 reset=1'b1; count_up =1'b0;
#2 reset=1'b0; count_up =1'b1;
end
endmodule

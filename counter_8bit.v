`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: blairtyx
// 
// Create Date: 2019/09/25 20:55:43
// Module Name: counter_8bit
// Project Name: EC605 20'Fall Lab 3 task 1
// Description: One simple 8-bit counter
//////////////////////////////////////////////////////////////////////////////////


module Counter8bit(
    input clk,rst,direction,
    input [7:0] maxium,
    input pause,
    output [7:0] counter
    );
    
    reg [7:0] CNT; //output & state
    
    always @(posedge clk or posedge rst)
    begin
        if (rst)
            CNT <= 0 ;// initial state 0
        else
            if (!pause)
                case (direction)
                 1: CNT <= (CNT < maxium)? CNT+1 : 0;
                 0: if (CNT==0 | CNT > maxium) CNT <= maxium; else CNT <= CNT -1;
                endcase
             else 
                CNT <= CNT;
    end    
    assign counter = CNT;
endmodule

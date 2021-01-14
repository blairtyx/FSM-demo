`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: blairtyx
// 
// Create Date: 2019/09/26 11:27:10
// Module Name: MooreStateMachine wrap around LED demo
// Project Name: EC605 20'Fall Lab3 task2
// Description: One simple Moore state machine demo, with 5 states in total
//////////////////////////////////////////////////////////////////////////////////


module MooreStateMachine(
    input clk,
    input rst,
    input  switch0,switch1,
    input pause,	
    input [7:0] maximum,
    output [3:0] LED
    );

    wire [7:0] CNT;//output of Counter8bit
    reg [3:0] state;//state of this FSM
    reg pause_reg;
    reg [7:0] last_counter, current_counter;
    parameter   init = 4'b0000,
                s_00 = 4'b0001,
                s_01 = 4'b0010,
                s_02 = 4'b0100,
                s_03 = 4'b1000;
                

    Counter8bit U1 (.clk(clk), .rst(rst), .direction(1), .maxium(maximum), .pause(pause_reg), .counter(CNT));
    /*[pause update block]
        update the value of [pause_reg]
            when 1. pause is on
              or 2. switch1 and switch0 are both zero or one
    */
    always@(pause or switch1 or switch0)
    begin
        if(pause | (!switch0 & !switch1) | (switch0 & switch1))
            pause_reg <= 1;
        else
            pause_reg <= 0;
    end
    
    /*[state update block]
        implement the function of a Moore State machine
    */
    always@(posedge clk or posedge rst)
    begin
        if(rst)
            begin
                state <= init;// reset the FSM to initial state
                last_counter <= 8'b00000000;// reset the last_counter to initial state, so no exception for reset
            end
        else if((switch0 == 1) & (switch1==0) & (current_counter == 0) & (last_counter == maximum))
             case (state)
                init: state <= s_00;
                s_00: state <= s_01;
                s_01: state <= s_02;
                s_02: state <= s_03;
                s_03: state <= init;
            endcase
        else if ((switch0 == 0) & (switch1==1) & (current_counter == 0) & (last_counter == maximum))
             case (state)
                init: state <= s_03;
                s_03: state <= s_02; 
                s_02: state <= s_01;
                s_01: state <= s_00;
                s_00: state <= init;
            endcase                       
    end
    

    /*[counter update block]
        update last_counter and current_counter when CNT is changed.
        make sure the state machine waits for a wrap around.
    */
    always@(CNT)
    begin
        last_counter <= current_counter;
        current_counter <= CNT;
    end

    
    //assign [reg state] to [wire LED] as the output of module
    assign LED = state;
endmodule

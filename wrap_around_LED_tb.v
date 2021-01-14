`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: blairtyx
// 
// Create Date: 2019/09/26 11:27:10
// Module Name: testbench for MooreStateMachine wrap around LED demo
// Project Name: EC605 20'Fall Lab3 task2
// Description: One simple Moore state machine demo, with 5 states in total
//////////////////////////////////////////////////////////////////////////////////


module task2_testbench(

    );
    reg clk, rst, switch0, switch1, pause;
    wire [3:0] LED;
    reg [7:0] maximum;

    MooreStateMachine U1 (.clk(clk), .rst(rst), .switch0(switch0), .switch1(switch1), .pause(pause), .maximum(maximum), .LED(LED));
        
    //initialization
    initial 
        begin
            rst <= 1;
            #10 rst <= 0;
            clk <= 1;
            pause <= 0;
            maximum <= 8'd20;
            switch0 <= 0;
            switch1 <= 0;
    end
    
    //clock 
    always
        begin
            #5 clk = ~clk;
    end
    
    //data block
    initial
        begin
            #18 switch0 = 1;
            switch1 = 0;
            
            #998 rst = 1;
            #52 rst = 0;
            #49 switch0 = 0;
            #49 switch1 = 1;
            #50 rst = 1;
            #52 rst = 0;
            #999 pause = 1;
            #23 pause = 0;
            #500 maximum = 8'd100;
            #2001 switch0 = 1;
            #50 switch1 = 0;
            #23 rst = 1;
            #34 rst = 0;
            #8000 maximum = 8'd10;
            #800 $finish;
    end
endmodule

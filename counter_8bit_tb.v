`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: blairtyx
// 
// Create Date: 2019/09/25 20:55:43
// Module Name: testbench for counter_8bit
// Project Name: EC605 20'Fall Lab 3 task 1 testbench
// Description: One simple 8-bit counter
//////////////////////////////////////////////////////////////////////////////////


module counter_testbench(

    );
    reg clk, rst, dir,  pause;
    wire [7:0] counter;
    reg [7:0] maximum;
    
    Counter8bit u1 (.clk(clk), .rst(rst), .direction(dir), .maxium(maximum), .pause(pause), .counter(counter));
    
    //initial block
    initial 
        begin
            rst = 1;
            #20 rst = 0;
            clk = 0;
            dir = 1;
            
            maximum = 8'h05;
            pause = 0;
    end
    
    //clock block
    always
        begin
            #5 clk = ~clk;
    end
    
    
    //data block
    initial
        begin 
            #100 maximum = 8'h0F;
            #200 rst = 1;
            #50 rst = 0;
            #100 pause = 1;
            #50 pause = 0;
            #200 maximum = 8'h07;
            #100 dir = 0;
            #100 maximum = 8'h20;
            #350 rst = 1;
            #50 rst = 0;
            #350 pause = 1;
            #50 pause = 0;
            #350 maximum = 8'h10;
            #200 dir = 1;
            #200 $finish;
    end

endmodule

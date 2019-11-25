`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2019 09:04:54 PM
// Design Name: 
// Module Name: LFUComparador_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module LFUComparador_tb();

    logic                   clk;
    logic [3:0]             count0;
    logic [3:0]             count1;
    logic [3:0]             count2;
    logic [3:0]             count3;

    logic [1:0]             cache_sel;


    LFUComparador #(4) dut1(clk, count0, count1, count2, count3, cache_sel);
    
    initial begin
    
    clk = 0;
    count0 = 0;
    count1 = 0;
    count2 = 0;
    count3 = 0; #4
    
    count0 = 4'b0000; count1 = 4'b0001; count2 = 4'b0010; count3 = 4'b0011; #4
    
    count0 = 4'b0100; count1 = 4'b0010; count2 = 4'b0011; count3 = 4'b0100; #4
    
    count0 = 4'b0000; count1 = 4'b0101; count2 = 4'b0010; count3 = 4'b0011; #4
    
    count0 = 4'b0000; count1 = 4'b0001; count2 = 4'b0111; count3 = 4'b0011; #4
    
    count0 = 4'b0000; count1 = 4'b0001; count2 = 4'b0010; count3 = 4'b1000; #4
    
    count0 = 4'b1001; count1 = 4'b0001; count2 = 4'b0010; count3 = 4'b0011; #4
    
    count0 = 4'b0000; count1 = 4'b1010; count2 = 4'b0010; count3 = 4'b0011; 
    
    end
      //Para el clock 
    always
        begin
        clk <= 1; # 2; clk <= 0; # 2;
    end

endmodule

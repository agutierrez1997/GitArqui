`timescale 1ns / 1ps

module LFUComparador_tb();

    logic [3:0]             count0;
    logic [3:0]             count1;
    logic [3:0]             count2;
    logic [3:0]             count3;

    logic [1:0]             cache_sel;


    LFUComparador #(4) dut(count0, count1, count2, count3, cache_sel);
    
    initial begin
    
    count0 = 0;
    count1 = 0;
    count2 = 0;
    count3 = 0; #5;
    
    count0 = 0; count1 = 0; count2 = 0; count3 = 0; #5;
    
    count0 = 7; count1 = 7; count2 = 7; count3 = 7; #5;
    
    count0 = 0; count1 = 0; count2 = 0; count3 = 2; #5;
    
    count0 = 0; count1 = 3; count2 = 3; count3 = 0; #5;
    
    count0 = 0; count1 = 2; count2 = 2; count3 = 2; #5;
    
    count0 = 4'b0000; count1 = 4'b0001; count2 = 4'b0010; count3 = 4'b0011; #4;
    
    count0 = 4'b0100; count1 = 4'b0010; count2 = 4'b0011; count3 = 4'b0100; #4;
    
    count0 = 4'b0000; count1 = 4'b0101; count2 = 4'b0010; count3 = 4'b0011; #4;
    
    count0 = 4'b0000; count1 = 4'b0001; count2 = 4'b0111; count3 = 4'b0011; #4;
    
    count0 = 4'b0000; count1 = 4'b0001; count2 = 4'b0010; count3 = 4'b1000; #4;
    
    count0 = 4'b1001; count1 = 4'b0001; count2 = 4'b0010; count3 = 4'b0011; #4;
    
    count0 = 4'b0000; count1 = 4'b1010; count2 = 4'b0010; count3 = 4'b0011; #4;
    
    end

endmodule

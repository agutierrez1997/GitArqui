`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2019 06:56:41 PM
// Design Name: 
// Module Name: Cache_TB
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


module Cache_TB();

    logic           clk;
    logic  [3:0]         write_enable;
    logic           read_enable;
    logic [9:0]     adress;
    logic [63:0]    data_in;
    logic           gen_reset;
    logic [63:0]    data_out1 = 0,data_out2 = 0 ,data_out3 = 0,data_out4 = 0;
    
    Cache #(10,64) dut1(clk, write_enable,read_enable, adress, data_in, gen_reset, data_out1,data_out2,data_out3,data_out4);
    
    initial begin
        clk = 0;
        write_enable = 0;
        read_enable = 0;
        adress = 0;
        data_in = 0;
        
        gen_reset = 1; #10
        gen_reset = 0; #10;
        
         adress = 10'b0000000011; data_in = 15; write_enable = 0; read_enable = 1; #10
        write_enable = 0; #10
        
        adress = 10'b0000010001; data_in = 15; write_enable = 1; read_enable = 1; #10
        write_enable = 1; #10
       
        adress = 10'b0000101100; data_in = 25; write_enable = 1; read_enable = 1; #10
        write_enable = 2; read_enable = 1; #10
        
        adress = 10'b0001000001; data_in = 35; write_enable = 2; read_enable = 1; #10
        write_enable = 4; read_enable = 0; #10
        
        adress = 10'b0000100000; data_in = 80; write_enable = 4; read_enable = 1; #20
        
        adress = 10'b0000011111; data_in = 20; write_enable = 8; read_enable = 1; #20
        read_enable = 1;
        adress = 10'b1111111111; data_in = 100; write_enable = 0; 
        
        
     end
     
     always
        begin
        clk <= 1; # 5; clk <= 0; # 5;
        end 
     
endmodule

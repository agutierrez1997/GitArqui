`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2019 05:39:52 PM
// Design Name: 
// Module Name: Cache
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


module Cache #(parameter bitsDirect = 10, sizeBitLine = 64 )
    (
    input logic                     clk,
     input logic [3:0]              write_enable,
     input logic                    read_enable,
     input logic [bitsDirect-1:0]   adress,
     input logic [sizeBitLine-1:0]  data_in,
     input logic                    gen_reset,
     output logic [sizeBitLine-1:0] data_out1, data_out2, data_out3, data_out4

    );
    
    BloqueCache BloqueCache1(clk,write_enable[0],read_enable,adress,data_in,gen_reset,data_out1);
    BloqueCache BloqueCache2(clk,write_enable[1],read_enable,adress,data_in,gen_reset,data_out2);
    BloqueCache BloqueCache3(clk,write_enable[2],read_enable,adress,data_in,gen_reset,data_out3);
    BloqueCache BloqueCache4(clk,write_enable[3],read_enable,adress,data_in,gen_reset,data_out4);
    
endmodule

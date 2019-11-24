`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2019 02:17:33 PM
// Design Name: 
// Module Name: Mux64Bits_TB
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


module Mux64Bits_TB
    ();
    logic [63:0]Data_RAM;
    logic [63:0]Data_CPU;
    logic seleccion;
    logic [63:0]Data_OutMux64;
    
    Mux64Bits #(64) dut1(Data_RAM,Data_CPU,seleccion,Data_OutMux64);
    
    initial begin
        Data_RAM = 0; Data_CPU = 0; seleccion = 0; #10;
        Data_RAM = 16; Data_CPU = 75; seleccion = 0; #10;
        Data_RAM = 16; Data_CPU = 75; seleccion = 1; #10;
        Data_RAM = 27; Data_CPU = 75; seleccion = 0; #10;
        Data_RAM = 16; Data_CPU = 556; seleccion = 1; #10;
    end
    
   
endmodule

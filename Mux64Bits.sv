`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2019 01:57:26 PM
// Design Name: 
// Module Name: Mux64Bits
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


module Mux64Bits # (parameter SizeDataMux = 64)
   (
    input logic [SizeDataMux-1:0] Data_RAM,
    input logic [SizeDataMux-1:0] Data_CPU,
    input logic                seleccion,
    output logic [SizeDataMux-1:0] Data_OutMux64
    );
    
    assign Data_OutMux64 = seleccion? Data_CPU:Data_RAM; //Si seleccion es 1, Data_OutMux64 = Data_CPU
                                                        //Si es 0, Data_OutMux64 = Data_RAM
    
    
endmodule

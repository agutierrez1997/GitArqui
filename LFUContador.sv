`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2019 08:28:07 PM
// Design Name: 
// Module Name: LFUContador
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

`timescale 1ns / 1ps


module LFUContador #(parameter bitsDirect = 10, sizeCounter = 4)
    (input logic                        clk,
     input logic                        write_enable,
     input logic                        read_enable,
     input logic [bitsDirect-1:0]       adress,
     input logic                        count_read,
     input logic                        gen_reset,
     output logic [sizeCounter-1:0]     count_out
     );
     
     logic [sizeCounter-1:0] counter[2**bitsDirect-1:0];
     //logic [bitsDirect-1:0] counter;
     //int counter;
     
     always_ff@(posedge clk or posedge gen_reset) begin
        if (gen_reset) counter <= '{default:'d0};

        else begin
            if (write_enable) counter[adress] <= 0;
            if (count_read)  count_out <= counter[adress];
            if (~count_read) count_out <= 4'bz;
            if (read_enable) counter[adress] <= counter[adress]+1;
        end
     end
     
     
endmodule

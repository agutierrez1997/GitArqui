`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2019 09:04:15 PM
// Design Name: 
// Module Name: LFUComparador
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


module LFUComparador #(parameter sizeCounter = 4)(
    
    input logic                         clk,
    input logic [sizeCounter-1:0]       count0,
    input logic [sizeCounter-1:0]       count1,
    input logic [sizeCounter-1:0]       count2,
    input logic [sizeCounter-1:0]       count3,
    
    output logic [1:0]                  cache_sel
    
    );

    always@(posedge clk) begin
        
        if (count0>=count1 && count2>=count3) begin
            
            if (count1>=count3) assign cache_sel = 2'b11;
            else assign cache_sel = 2'b01;
                
        end
    
        if (count0<count1 && count2<count3) begin
            
            if (count0>=count2) assign cache_sel = 2'b10;
            else assign cache_sel = 2'b00;
                
        end
        
        if (count0>=count1 && count2<=count3) begin
            
            if (count1>=count2) assign cache_sel = 2'b10;
            else assign cache_sel = 2'b01;
                
        end
        
        if (count0<count1 && count2>count3) begin
            
            if (count0>=count3) assign cache_sel = 2'b11;
            else assign cache_sel = 2'b00;
                
        end
    
    end
    
endmodule

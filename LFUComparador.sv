`timescale 1ns / 1ps

module LFUComparador #(parameter sizeCounter = 4)(
    
    input logic [sizeCounter-1:0]       count0,
    input logic [sizeCounter-1:0]       count1,
    input logic [sizeCounter-1:0]       count2,
    input logic [sizeCounter-1:0]       count3,
    
    output logic [3:0]                  cache_sel
    
    );
    
    logic [3:0] menor = 0;
    
    always_comb begin
        
        if (count0<=count1) menor = count0;

        else menor = count1;
        
        if (menor>=count2) menor = count2;
        
        if (menor>=count3) menor = count3;
        
        if (menor==count0) cache_sel = 4'b0001;
        if (menor==count1) cache_sel = 4'b0010;
        if (menor==count2) cache_sel = 4'b0100;
        if (menor==count3) cache_sel = 4'b1000;
    
    end
    
endmodule

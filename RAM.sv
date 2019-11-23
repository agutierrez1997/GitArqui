`timescale 1ns / 1ps


module RAM #(parameter N = 6, M = 32)
    (input logic            clk,
     input logic            write_enable,
     input logic [N-1:0]    adress,
     input logic [M-1:0]    data_in,
     output logic [M-1:0]   data_out
     );
     
     logic [M-1:0]mem[2**N-1:0];
     
     always_ff@(posedge clk)
        if (write_enable) mem[adress] <= data_in;
        
        assign data_out = mem[adress];
     
endmodule

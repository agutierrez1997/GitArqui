`timescale 1ns / 1ps


module BloqueCache #(parameter bitsDirect = 10, sizeBitLine = 64)
    (input logic                    clk,
     input logic                    write_enable,
     input logic                    read_enable,
     input logic [bitsDirect-1:0]   adress,
     input logic [sizeBitLine-1:0]  data_in,
     input logic                    gen_reset,
     output logic [sizeBitLine-1:0] data_out
     );
     
     logic [sizeBitLine-1:0] mem[2**bitsDirect-1:0];
     
     always_ff@(posedge clk or posedge gen_reset) begin
        if (gen_reset) mem <= '{default:'d0};
        else begin
            if(write_enable) mem[adress] <= data_in;
            if(read_enable) assign data_out = mem[adress];
            else assign data_out = 64'bz ; 
        end 
     end
endmodule

`timescale 1ns / 1ps


module RAM #(parameter bitsDirect = 6, sizeBitLine = 32)
    (input logic                    clk,
     input logic                    write_enable,
     input logic [bitsDirect-1:0]   adress,
     input logic [sizeBitLine-1:0]  data_in,
     input logic                    gen_reset,
     output logic [sizeBitLine-1:0] data_out
     );
     
     logic [sizeBitLine-1:0] mem[2**bitsDirect-1:0];
     
     always_ff@(posedge clk or posedge gen_reset) begin
        if (gen_reset) mem <= '{default:'d0};
        else if(write_enable) mem[adress] <= data_in;
        
        assign data_out = mem[adress];
     end
endmodule

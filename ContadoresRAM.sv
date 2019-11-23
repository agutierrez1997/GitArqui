`timescale 1ns / 1ps


module ContadoresRAM #(parameter bitsDirect = 6, sizeCounter = 4)
    (input logic                        clk,
     input logic                        write_enable,
     input logic [bitsDirect-1:0]       adress,
     input logic                        count_read,
     input logic                        count_reset,
     input logic                        gen_reset,
     output logic [bitsDirect-1:0]      counter,
     output logic [sizeCounter-1:0]     count_out
     );
     
     logic [sizeCounter-1:0] mem[2**bitsDirect-1:0];
     //logic [bitsDirect-1:0] counter;
     
     always_ff@(posedge clk) begin
        if (gen_reset) begin
        
        for (counter = 0; counter < (2**bitsDirect-1); counter++) mem[counter] = 0;
        
        end
        
        else begin
            if (write_enable && ~count_reset && ~gen_reset) mem[adress] <= mem[adress] + 1;
            if (count_reset && ~gen_reset) mem[adress] <= 0;
            if (count_read && ~count_reset && ~gen_reset) count_out = mem[adress];
        end
     end
     
     
endmodule

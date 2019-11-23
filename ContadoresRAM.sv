`timescale 1ns / 1ps


module ContadoresRAM #(parameter bitsDirect = 6, sizeCounter = 4)
    (input logic                        clk,
     input logic                        write_enable,
     input logic [bitsDirect-1:0]       adress,
     input logic                        count_read,
     input logic                        count_reset,
     input logic                        gen_reset,
     output logic [sizeCounter-1:0]     count_out
     );
     
     logic [sizeCounter-1:0] mem[2**bitsDirect-1:0];
     //logic [bitsDirect-1:0] counter;
     //int counter;
     
     always_ff@(posedge clk or posedge gen_reset) begin
        if (gen_reset) mem <= '{default:'d0};

        else begin
            if (write_enable && ~count_reset && ~gen_reset) mem[adress] <= mem[adress] + 1;
            if (count_reset && ~gen_reset) mem[adress] <= 0;
            if (count_read && ~count_reset && ~gen_reset) count_out = mem[adress];
        end
     end
     
     
endmodule

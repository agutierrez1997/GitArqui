`timescale 1ns / 1ps

module LFUContador #(parameter bitsDirect = 10, sizeCounter = 4)
    (input logic                        clk,
     input logic                        enable,
     input logic                        line_reset,
     input logic                        line_sum,
     input logic [bitsDirect-1:0]       address,
     input logic                        count_read,
     input logic                        gen_reset,
     output logic [sizeCounter-1:0]     count_out
     );
     
     logic [sizeCounter-1:0] counter[2**bitsDirect-1:0];
     
     always_ff @(posedge clk or posedge gen_reset) begin
        if (gen_reset) counter <= '{default:'d0};

        else begin
            //logica para reiniciar o sumar al contador de la linea
            if (enable)
                begin
                if (line_sum) counter[address] <= counter[address]+1;
                if (line_reset) counter[address] <= 0;
            end
            
            //logica para leer el conteo
            if (count_read)  count_out <= counter[address];
            else count_out <= 4'bz;
            end
 
     end   
     
endmodule

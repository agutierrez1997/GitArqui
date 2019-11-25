`timescale 1ns / 1ps

module BloqueTags #(parameter bitsDirect = 10, sizeBitLine = 37) //1 valid bit + 36 bits tag
    (input logic                    clk,
     input logic                    write_enable,
     input logic                    read_enable,
     input logic [bitsDirect-1:0]   adress,
     input logic [sizeBitLine-1:0]  data_in,
     input logic                    gen_reset,
     output logic [sizeBitLine-1:0] data_out
     );
     
     /*son 1024 líneas por bloque de tag, igual que en caché
       pero cada línea es de 37 bits*/
     logic [sizeBitLine-1:0] tag[2**bitsDirect-1:0];
     
     always_ff@(posedge clk or posedge gen_reset) begin
     
        if (gen_reset) tag <= '{default:'d0};
        
        else begin
            if(write_enable) tag[adress] <= data_in;
            if(read_enable) assign data_out = tag[adress];
            else assign data_out = 37'bz ;
        end 
     end
endmodule
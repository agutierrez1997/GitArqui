`timescale 1ns / 1ps


module ConjuntoTags #(parameter bitsDirect = 10, sizeBitLine = 37)
    (
     input logic                     clk,
     input logic [3:0]              write_enable,     //4 bits, uno para cada bloque de caché
     input logic                    read_enable,
     input logic [bitsDirect-1:0]   adress,
     input logic [sizeBitLine-1:0]  data_in, //el dato de entrada es comun a los 4 bloques (el tag)
     input logic                    gen_reset,
     output logic [sizeBitLine-1:0] data_out1, data_out2, data_out3, data_out4 //las salidas si son distintas para
                                                                                //cada bloque, salen los tags de las 4 lineas
                                                                                //que luego se comparan con "hit logic"
    );
    
    BloqueTags #(10,37) BloqueTags1(clk,write_enable[0],read_enable,adress,data_in,gen_reset,data_out1);
    BloqueTags #(10,37) BloqueTags2(clk,write_enable[1],read_enable,adress,data_in,gen_reset,data_out2);
    BloqueTags #(10,37) BloqueTags3(clk,write_enable[2],read_enable,adress,data_in,gen_reset,data_out3);
    BloqueTags #(10,37) BloqueTags4(clk,write_enable[3],read_enable,adress,data_in,gen_reset,data_out4);
    
endmodule

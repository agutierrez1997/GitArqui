`timescale 1ns / 1ps

module Cache #(parameter bitsDirect = 10, sizeBitLine = 64 )
    (
    input logic                     clk,
     input logic [3:0]              write_enable,     //4 bits, uno para cada bloque de caché
     input logic [1:0]              write_enable_cpu, //habilita escritura desde CPU
     input logic                    write_enable_ram, //habilita escritura desde RAM
     input logic                    read_enable,
     input logic [bitsDirect-1:0]   adress,
     input logic [sizeBitLine-1:0]  data_in, //el dato de entrada es comun a los 4 bloques
     input logic                    gen_reset,
     output logic [sizeBitLine-1:0] data_out1, data_out2, data_out3, data_out4 //las salidas si son distintas para
                                                                                //cada bloque, luego con muxes se escoge la deseada

    );
    
    BloqueCache #(10,64) BloqueCache1(clk,write_enable[0],write_enable_cpu,write_enable_ram,read_enable,adress,data_in,gen_reset,data_out1);
    BloqueCache #(10,64) BloqueCache2(clk,write_enable[1],write_enable_cpu,write_enable_ram,read_enable,adress,data_in,gen_reset,data_out2);
    BloqueCache #(10,64) BloqueCache3(clk,write_enable[2],write_enable_cpu,write_enable_ram,read_enable,adress,data_in,gen_reset,data_out3);
    BloqueCache #(10,64) BloqueCache4(clk,write_enable[3],write_enable_cpu,write_enable_ram,read_enable,adress,data_in,gen_reset,data_out4);
    
endmodule

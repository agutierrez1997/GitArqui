`timescale 1ns / 1ps

module LFUContadores #(parameter bitsDirect = 10, sizeCounter = 4)
    (input logic                        clk,
     input logic                        enable, //habilita el borrar o sumar a la linea
     input logic [3:0]                  line_reset, //para elegir cual de las 4 lineas borrar
     input logic [3:0]                  line_sum, //para elegir a cual de las 4 lineas sumarle
     input logic [bitsDirect-1:0]       address,
     input logic                        count_read, //para leer el contador de las lineas
     input logic                        gen_reset, //para reiniciar TODAS las lineas
     output logic [sizeCounter-1:0]     count_out0,
     output logic [sizeCounter-1:0]     count_out1,
     output logic [sizeCounter-1:0]     count_out2,
     output logic [sizeCounter-1:0]     count_out3
    );
    
    LFUContador #(10,4) Cont0 (clk,enable,line_reset[0],line_sum[0],address,count_read,gen_reset,count_out0);
    LFUContador #(10,4) Cont1 (clk,enable,line_reset[1],line_sum[1],address,count_read,gen_reset,count_out1);
    LFUContador #(10,4) Cont2 (clk,enable,line_reset[2],line_sum[2],address,count_read,gen_reset,count_out2);
    LFUContador #(10,4) Cont3 (clk,enable,line_reset[3],line_sum[3],address,count_read,gen_reset,count_out3);

endmodule

`timescale 1ns / 1ps

module LFUContadores_Testbench();

      logic             clk;
      logic             enable; //habilita el borrar o sumar a la linea
      logic [3:0]       line_reset; //para elegir cual de las 4 lineas borrar
      logic [3:0]       line_sum; //para elegir a cual de las 4 lineas sumarle
      logic [10-1:0]    address;
      logic             count_read; //para leer el contador de las lineas
      logic             gen_reset; //para reiniciar TODAS las lineas
      logic [4-1:0]     count_out0;
      logic [4-1:0]     count_out1;
      logic [4-1:0]     count_out2;
      logic [4-1:0]     count_out3;
      
LFUContadores #(10,4) dut(clk,enable,line_reset,line_sum,address,count_read,gen_reset,count_out0,count_out1,count_out2,count_out3);

initial begin

enable=0; line_reset=0; line_sum=0; address=0; count_read=0; gen_reset=1; #20;

gen_reset=0; #20;

count_read=1; address=10; #10;

line_sum=4'b0001; #10;

enable=1; #10;

line_sum=4'b0010; #10;

line_sum=4'b0000; #10;

enable=0; #10;

line_reset=4'b0001; #10;

enable=1; #10;


end

 //Para el clock 
    always
        begin
        clk <= 1; #5; clk <= 0; #5;
        end

endmodule

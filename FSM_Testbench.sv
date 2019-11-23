`timescale 1ns / 1ps

module FSM_Testbench();
     logic clk;
     logic reset;
     logic hit;
     logic Run;
     logic RW; //read/write
     logic Data_Ready;
     logic Data_ReadyM;
     logic Process_Data;
    
     logic [2:0] y;

FSM dut(clk, reset, hit, Run, RW, Data_Ready, Data_ReadyM, Process_Data, y);


initial begin
reset=0; hit=0; Run=0; RW=0; Data_Ready=0; Data_ReadyM=0; Process_Data=0; #10;

//Probando la secuencia de un read hit
Run=1; RW=0; #10;
hit=1; Run=0; #10;  //en cada estado se desactivan las señales del estado anterior
Data_Ready=1; hit=0; #10;
Data_Ready=0;

//Probando la secuencia de un read miss
Run=1; RW=0; #10;
hit=0; Run=0; #10;  //en cada estado se desactivan las señales del estado anterior
Data_ReadyM=1; hit=0; #10;
hit=1; Data_ReadyM=0; #10;
Data_Ready=1; hit=0; #10;
Data_Ready=0; #10;

//Probando la secuencia de un write hit
Run=1; RW=1; #10
hit=1; Run=0; RW=0; #10;
Process_Data=1; hit=0; #10;
Data_Ready=1; Process_Data=0; #10;
Data_Ready=0; #10;

//Probando la secuencia de un write hit
Run=1; RW=1; #10
hit=0; Run=0; RW=0; #10;
Process_Data=1; hit=0; #10;
Data_Ready=1; Process_Data=0; #10;
Data_Ready=0; #10;

end

//Para el clock 
always
    begin
    clk <= 1; # 5; clk <= 0; # 5;
    end 

endmodule

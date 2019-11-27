`timescale 1ns / 1ps

module main (

    input logic clk,
    //variables entre controlador y CPU
    input logic run,
    input logic RW,
    input logic [47:0] address,
    input logic reset,
    input logic [15:0] Data_In,
    output logic [15:0] Data_Out,
    
    //variables que deberian salir de la nube de control:
    /*
    input logic SelecMemCPU,   //seleccion de mux de datos de entrada a cache
    input logic ReadEnableTag, //habilita leer tags
    input logic ReadEnableData, //habilita leer cache
    input logic gen_reset, //para reiniciar todo
    input logic [1:0] write_enable_cpu, //para escribir desde el CPU 16 bits (escoge la palabra)
    input logic write_enable_ram, //para escribir 64 bits desde RAM
    input logic enable_contadores, //enable de los contadores, habilita sumar a la linea o borrar linea
    input logic count_read, //para leer la cuenta del LFU
    */
    
    //Variables entre controlador y RAM
    input logic [63:0] Line_In, //por ahora Line_In va a ser un dato desde RAM de 64 bits
    output logic [64:0] Line_Out
);
//Salidas de la maquina de estados:
    wire SelecMemCPU;   //seleccion de mux de datos de entrada a cache
    wire ReadEnableTag; //habilita leer tags
    wire ReadEnableData; //habilita leer cache
    wire gen_reset; //para reiniciar todo
    wire write_enable_ram; //para escribir 64 bits desde RAM
    wire enable_contadores; //enable de los contadores, habilita sumar a la linea o borrar linea
    wire count_read; //para leer la cuenta del LFU

//MUX que selecciona el dato que le entra a la cache, desde CPU o RAM
wire [63:0] DataOutMux_to_DataInCache;
Mux64Bits #(64) MuxMemCPU (Line_In, {48'b0,Data_In}, SelecMemCPU, DataOutMux_to_DataInCache);

//TAGS
wire validBit; //Como se va a manejar??
wire [36:0] TagsOut_to_HitLogicIn0; //valid bit + tags que se leen y van a la logica de Hit
wire [36:0] TagsOut_to_HitLogicIn1;
wire [36:0] TagsOut_to_HitLogicIn2;
wire [36:0] TagsOut_to_HitLogicIn3;
wire [3:0] write_enable_from_LFU; //es para tags y para datos (cache)
ConjuntoTags #(10,37) Tags(clk,write_enable_from_LFU,ReadEnableTag,address[11:2],{validBit,address[47:12]},gen_reset,TagsOut_to_HitLogicIn0, TagsOut_to_HitLogicIn1, TagsOut_to_HitLogicIn2, TagsOut_to_HitLogicIn3);

//Memoria CACHE
wire [63:0] DataOutCache0; //salen de cache y van al mux que deja pasar solo uno
wire [63:0] DataOutCache1;
wire [63:0] DataOutCache2;
wire [63:0] DataOutCache3;
Cache #(10,64) MemCache(clk,write_enable_from_LFU,address[1:0],write_enable_ram,ReadEnableData,address[11:2],DataOutMux_to_DataInCache,gen_reset,DataOutCache0,DataOutCache1,DataOutCache2,DataOutCache3);

//Logica de HIT (universo 6)
wire hit;
wire andout1, andout2,andout3, andout4; //salen de hit miss logic y van a read hit logic
HitMissLogic HitMiss(address[47:12],TagsOut_to_HitLogicIn0[35:0],TagsOut_to_HitLogicIn1[35:0],TagsOut_to_HitLogicIn2[35:0],TagsOut_to_HitLogicIn3[35:0],TagsOut_to_HitLogicIn0[36],TagsOut_to_HitLogicIn1[36],TagsOut_to_HitLogicIn2[36],TagsOut_to_HitLogicIn3[36],hit,andout1, andout2,andout3, andout4);

//ENCODER
wire [1:0] SelMuxLinea; //salida del encoder
Encoder #(2) enc({andout4,andout3,andout2,andout1},SelMuxLinea);

//Logica READ HIT
ReadHitLogic RHlogic(DataOutCache0,DataOutCache1,DataOutCache2,DataOutCache3,SelMuxLinea,address[1:0],Data_Out);

//LFU
wire [3:0] seleccion_LFU; //sale de comparacion LFU y elige donde se escribe en cache, donde se escribe el tag y cual contador se reinicia
wire [3:0] count_out0,count_out1,count_out2,count_out3; //salen de los contadores LFU para entrar a la comparacion de LFU
LFUContadores #(10,4) contadores (clk,enable_contadores,seleccion_LFU,{andout4, andout3,andout2, andout1},address[11:2],count_read,gen_reset,count_out0,count_out1,count_out2,count_out3);

//LFU COMPARADOR
LFUComparador #(4) LFUcomp (count_out0,count_out1,count_out2,count_out3,seleccion_LFU);

//Generación de Data_Ready
wire Data_Ready;
// hit & ~RW = read hit
// RW & hit = write hit
assign Data_Ready = (hit & ~RW)|(RW & hit);

//Generación de Data_ReadyM
wire Data_ReadyM;
assign Data_ReadyM = write_enable_ram;

//Generación de Process_Data
wire Process_Data;
assign Process_Data = RW & hit;

//MAQUINA DE ESTADOS
FSM maquina(clk,reset,hit,run,RW,Data_Ready,Data_ReadyM,Process_Data,SelecMemCPU,ReadEnableTag,ReadEnableData,gen_reset,write_enable_ram,enable_contadores,count_read);

endmodule
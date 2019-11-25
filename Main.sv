`timescale 1ns / 1ps

module main (
    input logic clk,
    
    //variables entre controlador y CPU
    input logic run,
    input logic RW,
    input logic [47:0] address,
    input logic [15:0] Data_In,
    output logic [15:0] Data_Out,
    
    //variables que deberian salir de la nube de control:
    input logic SelecMemCPU,   //seleccion de mux de datos de entrada a cache
    input logic ReadEnableTag, //habilita leer tags
    input logic ReadEnableData, //habilita leer cache
    input logic resetGeneral, //para reiniciar todo
    
    //Variables entre controlador y RAM
    input logic [63:0] Line_In, //por ahora Line_In va a ser un dato desde RAM de 64 bits
    output logic [64:0] Line_Out
);

wire [63:0] DataOutMux_to_DataInCache;
Mux64bits #(64) MuxMemCPU (Line_In, {48'b0,Data_In}, SelecMemCPU, DataOutMux_to_DataInCache);

wire validBit; //Como se va a manejar??
wire [36:0] TagsOut_to_HitLogicIn0; //valid bit + tags que se leen y van a la logica de Hit
wire [36:0] TagsOut_to_HitLogicIn1;
wire [36:0] TagsOut_to_HitLogicIn2;
wire [36:0] TagsOut_to_HitLogicIn3;
//hay un problema con el write enable de los tags, la entrada son 4 bits pero lo que viene de LFU son 2
ConjuntoTags #(10,37) Tags(clk,???,ReadEnableTag,address[11:2],{validBit,address[47:12]},resetGeneral,TagsOut_to_HitLogicIn0, TagsOut_to_HitLogicIn1, TagsOut_to_HitLogicIn2, TagsOut_to_HitLogicIn3);




endmodule
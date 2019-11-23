`timescale 1ns / 1ps

/*
A esta maquina de estados le faltan
entradas y salidas,
es solo un avance
*/

//Finite State Machine
module FSM (
    input logic clk,
    input logic reset,
    input logic hit,
    input logic Run,
    input logic RW, //read/write
    input logic Data_Ready,
    input logic Data_ReadyM,
    input logic Process_Data,
    
    output logic y //las salidas aun se deben definir
    );
    
//se crea el tipo de variable 'statetype'
typedef enum logic [2:0] //3 bits, porque son 8 posibles estados
    {idle,
     read,
     write,
     readHit,
     writeHit,
     readMiss,
     writeMiss,
     writeThrough} statetype;
     
//se tiene 2 señales tipo statetype:
statetype [1:0] state, nextstate;

// logica reset:
always_ff @(posedge clk, posedge reset)
    if (reset)  state <=idle;
    else        state <=nextstate;
    
// logica de estado siguiente:
always_comb

    case (state)
        idle:
            if (Run) begin
                if (RW) nextstate <=write; //RW=1 => write
                else    nextstate <=write; //RW=0 => read
            end
            
        read:
            if (hit) nextstate <=readHit;
            else     nextstate <=readMiss;
            
        write:
            if (hit) nextstate <=writeHit;
            else     nextstate <=writeMiss;
            
        readHit:
            if (Data_Ready) nextstate <=idle;
            
        writeHit:
            if (Process_Data) nextstate <=writeThrough;
            
        readMiss:
            if (Data_ReadyM) nextstate <=read;
            
        writeMiss:
            if (Process_Data) nextstate <=writeThrough;
            
        writeThrough:
            if (Data_Ready) nextstate <=idle;
            
        default:
            nextstate <=idle;
    endcase
    
 // logica de salida
 
 assign y=(state==idle); //se asigna 1 a "y" cuando el estado es "idle" (ejemplo)
 
 endmodule

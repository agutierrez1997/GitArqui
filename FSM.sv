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
    output logic SelecMemCPU,
    output logic ReadEnableTag,
    output logic ReadEnableData,
    output logic gen_reset,
    output logic write_enable_ram,
    output logic enable_contadores,
    output logic count_read,
    output logic [2:0] salida
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
     
//se tiene 2 seÃƒÂ±ales tipo statetype:
statetype [2:0] state, nextstate;

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
                else    nextstate <=read; //RW=0 => read
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
            if (Data_ReadyM) nextstate <=write;
            
        writeThrough:
            if (Data_Ready) nextstate <=idle;
            
        default:
            nextstate <=idle;
    endcase
    
 // logica de salida
 always_comb
 if (state==idle) begin
    SelecMemCPU =0;          
    ReadEnableTag = 0;        
    ReadEnableData = 0;      
    gen_reset = 0;           
    write_enable_ram = 0;     
    enable_contadores = 0;    
    count_read = 0;
    salida=3'b000;           
 
 end
 else if (state==read) begin
    SelecMemCPU =0;          
    ReadEnableTag = 1;        
    ReadEnableData = 1;      
    gen_reset = 0;           
    write_enable_ram = 0;     
    enable_contadores = 0;    
    count_read = 0;
    salida=3'b001;
 
 end
 else if (state==readHit) begin
    SelecMemCPU =0;          
    ReadEnableTag = 1;        
    ReadEnableData = 1;      
    gen_reset = 0;           
    write_enable_ram = 0;     
    enable_contadores = 1;    
    count_read = 0;
    salida=3'b011;
 end
 else if (state==readMiss) begin
    SelecMemCPU = 0; //Si es 0, se selecciona la RAM          
    ReadEnableTag = 0;        
    ReadEnableData = 0;      
    gen_reset = 0;           
    write_enable_ram = 1;     
    enable_contadores = 1;    
    count_read = 1;
    salida=3'b100;
 
 end
 else if (state==write) begin
    SelecMemCPU =0;          
    ReadEnableTag = 1;        
    ReadEnableData = 0;      
    gen_reset = 0;           
    write_enable_ram = 0;     
    enable_contadores = 0;    
    count_read = 0;
    salida=3'b010;
 end
 else if (state==writeHit) begin
    SelecMemCPU = 1;  //Escribe desde el CPU        
    ReadEnableTag = 0;        
    ReadEnableData = 0;      
    gen_reset = 0;           
    write_enable_ram = 0;     
    enable_contadores = 1;    
    count_read = 0;
    salida=3'b101;
 end
 else if (state==writeMiss) begin
    SelecMemCPU = 0;          
    ReadEnableTag = 0;        
    ReadEnableData = 0;      
    gen_reset = 0;           
    write_enable_ram = 1;     
    enable_contadores = 1;    
    count_read = 1;
    salida=3'b110;
 end
 else if (state==writeThrough) begin
    SelecMemCPU =0;          
    ReadEnableTag = 0;        
    ReadEnableData = 0;      
    gen_reset = 0;           
    write_enable_ram = 0;     
    enable_contadores = 0;    
    count_read = 0;
    salida=3'b111;
 end
 
 endmodule

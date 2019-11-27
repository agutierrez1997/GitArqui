`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.11.2019 00:19:12
// Design Name: 
// Module Name: TB_FSM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TB_FSM();

    logic clk;
    logic reset;
    logic hit;
    logic Run;
    logic RW; //read/write
    logic Data_Ready;
    logic Data_ReadyM;
    logic Process_Data;
    logic SelecMemCPU;
    logic ReadEnableTag;
    logic ReadEnableData;
    logic gen_reset;
    logic write_enable_ram;
    logic enable_contadores;
    logic count_read;
    logic [2:0] salida;
    
    
    FSM dut(clk,reset,hit,Run,RW,Data_Ready,Data_ReadyM,Process_Data,SelecMemCPU,ReadEnableTag,ReadEnableData,gen_reset,write_enable_ram,enable_contadores,count_read,salida);
    
    always
        begin
        clk <=1;#5;clk <=0;#5;
    end
    
    initial begin
             
    reset = 0;       
    hit= 0;         
    Run = 0;         
    RW = 0; //read/wr
    Data_Ready =0;  
    Data_ReadyM = 0; 
    Process_Data = 0;
    #10;
    
    
    //Write
    reset = 0;       
    hit= 0;         
    Run = 1;         
    RW = 1; //read/wr
    Data_Ready =0;  
    Data_ReadyM = 0; 
    Process_Data = 0;
    #10;
    
    //WriteMiss
    reset = 0;        
    hit= 0;           
    Run = 1;          
    RW = 1; //read/wr 
    Data_Ready =0;    
    Data_ReadyM = 0;  
    Process_Data = 0; 
    #10;              
    
    //Write
    reset = 0;        
    hit= 0;           
    Run = 1;          
    RW = 1; //read/wr 
    Data_Ready =0;    
    Data_ReadyM = 1;  
    Process_Data = 0; 
    #10;
    
    
 //WriteHit                 
reset = 0;         
hit= 1;            
Run = 1;           
RW = 1; //read/wr  
Data_Ready =0;     
Data_ReadyM = 0;   
Process_Data = 0;  
#10; 
  
 //Writethrough
reset = 0;         
hit= 1;            
Run = 1;           
RW = 1; //read/wr  
Data_Ready =0;     
Data_ReadyM = 0;   
Process_Data = 1;  
#10; 


//Idle
reset = 0;         
hit= 0;            
Run = 0;           
RW = 0; //read/wr  
Data_Ready =1;     
Data_ReadyM = 0;   
Process_Data = 1;  
#10; 




           
    
    
    
    
    end
    
endmodule

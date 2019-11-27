`timescale 1ns / 1ps

module Main_Testbench();

    logic clk;
    
    //variables entre controlador y CPU
    logic run;
    logic RW;
    logic [47:0] address;
    logic reset;
    logic [15:0] Data_In;
    logic [15:0] Data_Out;
 
    
    
    //Variables entre controlador y RAM
    logic [63:0] Line_In; //por ahora Line_In va a ser un dato desde RAM de 64 bits
    logic [64:0] Line_Out;
    
main dut(clk,run,RW,address,reset,Data_In,Data_Out,Line_In,Line_Out);

    initial begin
    reset= 1;run=0; RW=0;address=0;Data_In=0;Line_In=2814749; #10;
    
    reset=0;run=1; RW=0;address=6000;Data_In=0;Line_In=2814749;#10;

                  
    
  end  
    always
    begin
    clk<=0; #5;
    clk<=1; #5;
    end
   
endmodule

`timescale 1ns / 1ps


module LFUContador_tb(

    );
    logic           clk;
    logic           write_enable;
    logic           read_enable;
    logic [9:0]     adress;
    logic           count_read;
    logic           gen_reset;
    logic [3:0]     count_out;

    LFUContador #(10,4) dut1(clk, write_enable, read_enable, adress, count_read, gen_reset, count_out);

    initial begin
        clk = 0;
        write_enable = 0;
        read_enable = 0;
        adress = 0;
        count_read = 0;
        
        //data_out = 0; #10
        
        gen_reset = 1; #8
        gen_reset = 0; #8
        
        adress = 'b000000001; write_enable = 1; #4
        
        adress = 'b000000010; write_enable = 1; #4
        
        adress = 'b000000100; write_enable = 1; #4
        
        write_enable = 0; #4
        
        /////////////////////////////////////////////////////
        
        adress = 'b000000001; read_enable = 1; #4
        
        adress = 'b000000001; read_enable = 1; #4
        
        adress = 'b000000001; read_enable = 1; #4
        
        /////////////////////////////////////////////////////
        
        adress = 'b000000010; read_enable = 1; #4
        
        adress = 'b000000010; read_enable = 1; #4
        
        adress = 'b000000010; read_enable = 1; #4
        
        adress = 'b000000010; read_enable = 1; #4
        
        adress = 'b000000010; read_enable = 1; #4
        
        read_enable = 0; #4
        
        ///////////////////////////////////////////////////

        adress = 'b000000001; count_read = 1; #4
        
        adress = 'b000000010; count_read = 1; #4
        
        adress = 'b000000100; count_read = 1; #4
        
        count_read = 0; #4
        
        /////////////////////////////////////////////////
        
        adress = 'b000000001; write_enable = 1; #4
        write_enable = 0; count_read = 1; 

    end
    
   //Para el clock 
    always
        begin
        clk <= 1; # 2; clk <= 0; # 2;
        end 
        
    
        
endmodule


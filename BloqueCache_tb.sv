`timescale 1ns / 1ps


module BloqueCache_tb(

    );
    logic           clk;
    logic           write_enable;
    logic           read_enable;
    logic [9:0]     adress;
    logic [31:0]    data_in;
    logic           gen_reset;
    logic [31:0]    data_out;

    BloqueCache #(10,32) dut1(clk, write_enable,read_enable, adress, data_in, gen_reset, data_out);

    initial begin
        clk = 0;
        write_enable = 0;
        read_enable = 0;
        adress = 0;
        data_in = 0;
        //data_out = 0; #10
        
        gen_reset = 1; #10
        gen_reset = 0; #10
        
        adress = 10'b0000000011; data_in = 15; write_enable = 0; read_enable = 1; #10
        write_enable = 0; #10
        
        adress = 10'b0000010001; data_in = 15; write_enable = 1; read_enable = 0; #10
        write_enable = 0; #10
       
        adress = 10'b0000101100; data_in = 25; write_enable = 1; read_enable = 1; #10
        write_enable = 0; read_enable = 1; #10
        
        adress = 10'b0001000001; data_in = 35; write_enable = 1; read_enable = 1; #10
        write_enable = 0; read_enable = 0; #10
        
        adress = 10'b0000100000; data_in = 80; write_enable = 0; read_enable = 0; #20
        
        adress = 10'b0000011111; data_in = 20; write_enable = 1; read_enable = 1; #20
        read_enable = 0;
        adress = 10'b1111111111; data_in = 100; write_enable = 1; 
        
    end
    
   //Para el clock 
    always
        begin
        clk <= 1; # 5; clk <= 0; # 5;
        end 
        
    
        
endmodule


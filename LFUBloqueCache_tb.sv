`timescale 1ns / 1ps

module LFUBloqueCache_tb(

    );
    logic           clk;
    logic           write_enable;
    logic [1:0]     write_enable_cpu; //habilita escritura desde CPU
    logic           write_enable_ram; //habilita escritura desde RAM
    logic           read_enable;
    logic [9:0]     adress;
    logic [63:0]    data_in;
    logic           gen_reset;
    
    logic [63:0]    data_out;
    logic [9:0]     min_adress;
    logic [3:0]     minCounter;
    //logic [9:0]     CountOut;

    //BloqueCache #(10,64,4) dut1(clk, write_enable,write_enable_cpu,write_enable_ram,read_enable, adress, data_in, gen_reset, data_out, min_adress);

    LFUBloqueCache #(10,64,4) dut1(clk, write_enable,write_enable_cpu,write_enable_ram,read_enable, adress, data_in, gen_reset, data_out, min_adress, minCounter);

    initial begin
        clk = 0;
        write_enable = 0;
        write_enable_cpu = 0;
        write_enable_ram = 0;
        read_enable = 0;
        adress = 0;
        data_in = 0;
        //data_out = 0; #10
        
        gen_reset = 1; #10
        gen_reset = 0; #10
        
        adress = 10'b0000000001; data_in = 15; write_enable = 0; read_enable = 1; #10
        write_enable = 1; write_enable_ram = 1; #10
        
        write_enable_ram = 0; write_enable_cpu = 2'b01; #10;
        write_enable_cpu = 2'b10; #10;
        write_enable_cpu = 2'b11; #10;
        write_enable = 0; #10;
        
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


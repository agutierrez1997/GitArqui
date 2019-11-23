`timescale 1ns / 1ps


module ContadoresRAM_tb(

    );
    logic           clk;
    logic           write_enable;
    logic [5:0]     adress;
    logic           count_read;
    logic           count_reset;
    logic           gen_reset;
    logic [3:0]     count_out;

    ContadoresRAM #(6,4) dut1(clk, write_enable, adress, count_read, count_reset, gen_reset, count_out);

    initial begin
        clk = 0;
        write_enable = 0;
        adress = 0;
        count_read = 0;
        count_reset = 0;
        gen_reset = 0;
        //data_out = 0; #10
        
        gen_reset = 1; #10
        gen_reset = 0; #10
        
        adress = 'b000001; count_read = 1; count_reset = 0; write_enable = 1; #10
        write_enable = 0; #10
        
        adress = 'b000010; count_read = 1; count_reset = 0; write_enable = 1; #10
        write_enable = 0; #10
        
        adress = 'b000100; count_read = 1; count_reset = 0; write_enable = 1; #10
        write_enable = 0; #10
        
        adress = 'b001000; count_read = 1; count_reset = 0; write_enable = 1; #10
        write_enable = 0; #10
        
        adress = 'b000001; count_read = 1; count_reset = 0; write_enable = 1; #10
        write_enable = 0; #10
        
        adress = 'b000010; count_read = 1; count_reset = 0; write_enable = 1; #10
        write_enable = 0; #10
        
        adress = 'b000010; count_read = 1; count_reset = 0; write_enable = 1; #10
        write_enable = 0; #10
        
        adress = 'b000010; count_read = 1; count_reset = 1; write_enable = 1; #10
        write_enable = 0; count_reset = 0; #10 
        
        adress = 'b111110; count_read = 1; #10
        adress = 'b111111; count_read = 1;
    end
    
   //Para el clock 
    always
        begin
        clk <= 1; # 5; clk <= 0; # 5;
        end 
        
    
        
endmodule


`timescale 1ns / 1ps


module RAM_tb(

    );
    logic           clk;
    logic           write_enable;
    logic [5:0]     adress;
    logic [31:0]    data_in;
    logic           gen_reset;
    logic [31:0]    data_out;

    RAM #(6,32) dut1(clk, write_enable, adress, data_in, gen_reset, data_out);

    initial begin
        clk = 0;
        write_enable = 0;
        adress = 0;
        data_in = 0;
        //data_out = 0; #10
        
        gen_reset = 1; #10
        gen_reset = 0; #10
        
        adress = 'b000001; data_in = 15; write_enable = 0; #10
        write_enable = 0; #10
        
        adress = 'b000001; data_in = 15; write_enable = 1; #10
        write_enable = 0; #10
        
        adress = 'b000010; data_in = 25; write_enable = 1; #10
        write_enable = 0; #10
        
        adress = 'b000100; data_in = 35; write_enable = 1; #10
        write_enable = 0; #10
        
        adress = 'b000010; data_in = 80; write_enable = 0; #20
        
        adress = 'b000001; data_in = 20; write_enable = 0; #20
        
        adress = 'b111111;
        
    end
    
   //Para el clock 
    always
        begin
        clk <= 1; # 5; clk <= 0; # 5;
        end 
        
    
        
endmodule


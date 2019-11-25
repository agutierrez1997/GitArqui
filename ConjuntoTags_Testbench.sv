`timescale 1ns / 1ps

module ConjuntoTags_Testbench();
     logic          clk;
     logic [3:0]    write_enable;     //4 bits, uno para cada bloque de caché
     logic          read_enable;
     logic [10-1:0] adress;
     logic [37-1:0] data_in; //el dato de entrada es comun a los 4 bloques (el tag)
     logic          gen_reset;
     logic [37-1:0] data_out1, data_out2, data_out3, data_out4;

ConjuntoTags #(10,37) dut1(clk, write_enable,read_enable, adress, data_in, gen_reset, data_out1,data_out2,data_out3,data_out4);


    initial begin
        clk = 0;
        write_enable = 0;
        read_enable = 0;
        adress = 0;
        data_in = 0;
        
        gen_reset = 1; #10
        gen_reset = 0; #10;
        
        adress = 10'b0000000001; data_in = 15; write_enable = 4'b0000; read_enable = 1; #10;
        write_enable = 4'b0001; #10;
        write_enable = 4'b0010; #10;
        write_enable = 4'b0100; #10;
        write_enable = 4'b1000; #10;
        
        write_enable = 4'b0000; data_in = 31; #10;
        
        write_enable = 4'b0001; #10;
        write_enable = 4'b0010; #10;
        write_enable = 4'b0100; #10;
        write_enable = 4'b1000; #10;
        
        write_enable = 4'b0000; adress = 10'b0000000010; #10;
        
        adress = 10'b0000000001; #10;
        
    end

always
        begin
        clk <= 1; # 5; clk <= 0; # 5;
        end 
     

endmodule

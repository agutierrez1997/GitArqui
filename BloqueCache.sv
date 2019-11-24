`timescale 1ns / 1ps

module BloqueCache #(parameter bitsDirect = 10, sizeBitLine = 64)
    (input logic                    clk,
     input logic                    write_enable, //enable general
     input logic [1:0]              write_enable_cpu, //habilita escritura desde CPU
     input logic                    write_enable_ram, //habilita escritura desde RAM
     input logic                    read_enable,
     input logic [bitsDirect-1:0]   adress,
     input logic [sizeBitLine-1:0]  data_in,
     input logic                    gen_reset,
     output logic [sizeBitLine-1:0] data_out
     );
     
     /*Se crea la memoria:
     [sizeBitLine-1:0] indica el ancho de la palabra (64bits)
     [2**bitsDirect-1:0] indica la cantidad de direcciones (1024)*/
     logic [sizeBitLine-1:0] mem[2**bitsDirect-1:0];
     
     //logica de read/write:
     always_ff@(posedge clk or posedge gen_reset) begin
        if (gen_reset) mem <= '{default:'d0};
        
        else begin
            if(write_enable) begin //si no se activa esta señal, no se hace ningún write
                
                if(write_enable_ram) mem[adress] <= data_in; //desde ram se escriben los 64 bits
                
                /*se usa "else if" para que no haga write desde cpu si
                  ya se esta haciendo write desde RAM*/
                else if (write_enable_cpu==2'b00) mem[adress][15:0]  <= data_in[15:0];
                else if (write_enable_cpu==2'b01) mem[adress][31:16] <= data_in[15:0];
                else if (write_enable_cpu==2'b10) mem[adress][47:32] <= data_in[15:0];
                else if (write_enable_cpu==2'b11) mem[adress][63:48] <= data_in[15:0];
                /*se usan siempre los bits menos significativos de data_in porque
                  ahi va a estar el dato que viene desde el CPU*/
            end
            
            if(read_enable) assign data_out = mem[adress];
            else assign data_out = 64'bz ; //si no se lee, la salida se tiene en alta impedancia
        end 
     end
endmodule

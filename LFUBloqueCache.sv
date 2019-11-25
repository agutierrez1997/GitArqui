`timescale 1ns / 1ps

module LFUBloqueCache #(parameter bitsDirect = 10, sizeBitLine = 64, sizeCounter = 4)
    (input logic                    clk,
     input logic                    write_enable, //enable general
     input logic [1:0]              write_enable_cpu, //habilita escritura desde CPU
     input logic                    write_enable_ram, //habilita escritura desde RAM
     input logic                    read_enable,
     input logic [bitsDirect-1:0]   adress,
     input logic [sizeBitLine-1:0]  data_in,
     input logic                    gen_reset,
     
     //input logic                    count_read,
     
     
     output logic [sizeBitLine-1:0] data_out,
     
     output logic [bitsDirect-1:0]  min_adress,
     
     output logic [sizeCounter-1:0] minCounter
     
     //output logic [bitsDirect-1:0] CountOut
     );
     
     /*Se crea la memoria:
     [sizeBitLine-1:0] indica el ancho de la palabra (64bits)
     [2**bitsDirect-1:0] indica la cantidad de direcciones (1024)*/
     logic [sizeBitLine-1:0] mem[2**bitsDirect-1:0];
     
     logic [sizeCounter-1:0] counter[2**bitsDirect-1:0];
     
     logic [bitsDirect-1:0] dirArriba;
     
     logic [bitsDirect-1:0] dirAbajo;
     
     assign dirArriba = counter[adress-1];
     assign dirAbajo = counter[adress+1];
     
     //logic [sizeCounter-1:0] minCounter;
     
     //assign CountOut = counter[adress];
     
     //logica de read/write:
     always_ff@(posedge clk or posedge gen_reset) begin
        if (gen_reset) begin 
        
        mem <= '{default:'d0};
        counter <= '{default:'d0};
        minCounter <= 4'b1111;
        min_adress <= '{default:'d0};
        
        end
        
        else begin
            if(write_enable) begin //si no se activa esta señal, no se hace ningún write
                
                counter[adress] <= 0;
                
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
            
            if(read_enable) begin
            
                assign data_out = mem[adress];
                counter[adress] <= counter[adress]+1;
                
                //if (counter[adress]<=minCounter) begin
                //    minCounter <= counter[adress];
                //    min_adress <= adress;
                //end
                
                //////////////////////////////////////////////////////////
                
                //*******************Lógica que toma en cuenta valores adyacentes del contador
                
                if(counter[adress]>=minCounter && counter[adress]>=dirArriba && counter[adress]>=dirAbajo && minCounter<=dirArriba && minCounter<=dirAbajo) begin
                    minCounter <= minCounter;
                    min_adress <= min_adress;
                //
                end
                //
                if(counter[adress]>minCounter && minCounter>=dirArriba && minCounter<dirAbajo) begin
                    minCounter <= dirArriba;
                    min_adress <= adress-1;
                end
                //
                if(counter[adress]>minCounter && minCounter<dirArriba && minCounter>=dirAbajo) begin
                    minCounter <= dirAbajo;
                    min_adress <= adress+1;
                
                end
                //
                if(counter[adress]>minCounter && minCounter<dirArriba && minCounter<dirAbajo && dirAbajo>=dirArriba) begin
                    minCounter <= dirArriba;
                    min_adress <= adress-1;
                
                end
                //
                if(counter[adress]>minCounter && minCounter<dirArriba && minCounter<dirAbajo && dirAbajo<dirArriba) begin
                    minCounter <= dirAbajo;
                    min_adress <= adress+1;
                
                end
                //
                if(counter[adress]<=minCounter && counter[adress]<dirArriba && counter[adress]<dirAbajo) begin
                    minCounter <= counter[adress];
                    min_adress <= adress;
                
                end
                //
                if(counter[adress]<=minCounter && counter[adress]>=dirArriba && counter[adress]<dirAbajo) begin
                    minCounter <= dirArriba;
                    min_adress <= adress-1;
                
                end
                //
                if(counter[adress]<=minCounter && counter[adress]<dirArriba && counter[adress]>=dirAbajo) begin
                    minCounter <= dirAbajo;
                    min_adress <= adress+1;
                
                end
                //
                if(counter[adress]<=minCounter && counter[adress]>=dirArriba && counter[adress]>=dirAbajo && dirAbajo>=dirArriba) begin
                    minCounter <= dirArriba;
                    min_adress <= adress-1;
                
                end
                //
                if(counter[adress]<=minCounter && counter[adress]>=dirArriba && counter[adress]>=dirAbajo && dirAbajo<dirArriba) begin
                    minCounter <= dirAbajo;
                    min_adress <= adress+1;
                
                end
                                
                /////////////////////////////////////////////////////////
           
                if (adress == min_adress) minCounter <= minCounter+1;
                
            end
            
            else assign data_out =  64'bz ; //si no se lee, la salida se tiene en alta impedancia
        end 
     end
endmodule

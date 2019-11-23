`timescale 1ns / 1ps

module Encoder #(parameter N=2) //Parametro => # bits de salida
    (input logic [2**N-1:0] in,
     output logic [N-1:0] out
  );
  integer i;
  
  always_comb
    begin
    out = 0;  /*valor predeterminado por si
                todas las entradas son cero*/
    for (i=2**N-1; i>=0; i=i-1)
        if (in[i]) out = i;
    end
endmodule
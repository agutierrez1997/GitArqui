module ORHit(
    input logic bloque1,bloque2,bloque3,bloque4,
    output logic hit
    );
    
    assign hit = bloque1 | bloque2 | bloque3 | bloque4;
endmodule
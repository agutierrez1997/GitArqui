module ComparadorTag(
    input logic [35:0] TagAddress,TagBloque,
    output logic salida
    );
    
    assign salida = (TagAddress == TagBloque);
endmodule
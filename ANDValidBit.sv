module ANDValidBit(
    input logic salidaComparador,ValidBit,
    output logic salidaAND
    );
    
    assign salidaAND = salidaComparador & ValidBit;
endmodule
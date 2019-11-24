module ReadHitLogic(
    input logic [63:0] Linea1,Linea2,Linea3,Linea4,
    input logic [1:0] selecEncoder, wordAddress,
    output logic [15:0] Data_Out
    );
    
    wire [63:0] salidaMux1;
    
    Mux4a1Parametrizable #(64) mux64bits(Linea1,Linea2,Linea3,Linea4,selecEncoder,salidaMux1);
    
    wire [15:0] palabra1;
    wire [15:0] palabra2;
    wire [15:0] palabra3;
    wire [15:0] palabra4;
    
    assign palabra1 = salidaMux1[15:0];
    assign palabra2 = salidaMux1[31:16];
    assign palabra3 = salidaMux1[47:32];
    assign palabra4 = salidaMux1[63:48];
    
    
    Mux4a1Parametrizable #(16) mux16bits(palabra1,palabra2,palabra3,palabra4,wordAddress,Data_Out);

endmodule
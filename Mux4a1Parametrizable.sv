module Mux4a1Parametrizable #(parameter N=64)(
    input logic [N-1:0] In1,In2,In3,In4,
    input logic [1:0] selec,
    output logic [N-1:0] Out
    );
    
    assign Out = selec[1] ? (selec[0] ? In4:In3)
                          : (selec[0] ? In2:In1);
                          
endmodule
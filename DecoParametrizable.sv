module DecoParametrizable #(parameter N=3)
   (input logic [N-1:0] in,
    output logic [2**N-1:0] out);
    
always_comb
    begin
    out = 0;
    out[in] = 1;
    end
endmodule
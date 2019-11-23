`timescale 1ns / 1ps

module Encoder_Testbench #(parameter N=2)();

    logic [2**N-1:0] in;
    logic [N-1:0] out;

Encoder #(2)dut(in,out);

initial begin

in=4'b0000; #10;
in=4'b0001; #10;
in=4'b0010; #10;
in=4'b0100; #10;
in=4'b1000; #10;
in=4'b0100; #10;

end
endmodule
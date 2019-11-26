module HitMissLogic(
    input logic [35:0] tagAddress,tagBloque1,tagBloque2,tagBloque3,tagBloque4,
    input logic vBit1,vBit2,vBit3,vBit4, //Valid Bit de cada bloque de Tags
    output logic hit, //Si es 1 es hit, sino es miss
    output logic andout1,andout2,andout3,andout4
    );

wire salidaComp1;
wire salidaComp2;
wire salidaComp3;
wire salidaComp4;

ComparadorTag compBloque1(tagAddress,tagBloque1,salidaComp1);
ComparadorTag compBloque2(tagAddress,tagBloque2,salidaComp2);
ComparadorTag compBloque3(tagAddress,tagBloque3,salidaComp3);
ComparadorTag compBloque4(tagAddress,tagBloque4,salidaComp4);


wire salidaAND1;
wire salidaAND2;
wire salidaAND3;
wire salidaAND4;


ANDValidBit and1(salidaComp1,vBit1,salidaAND1);
ANDValidBit and2(salidaComp2,vBit2,salidaAND2);
ANDValidBit and3(salidaComp3,vBit3,salidaAND3);
ANDValidBit and4(salidaComp4,vBit4,salidaAND4);

assign andout1 = salidaAND1;
assign andout2 = salidaAND2;
assign andout3 = salidaAND3;
assign andout4 = salidaAND4;


ORHit ORHit(salidaAND1,salidaAND2,salidaAND3,salidaAND4,hit);    //Si alguna de las entradas de la OR es 1, hay un hit

endmodule
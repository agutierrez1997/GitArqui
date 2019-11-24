module TB_ReadHitLogic();
logic [63:0] linea0,linea1,linea2,linea3;
logic [1:0] s1,s2;
logic [15:0] Data_Out ;  


ReadHitLogic dut(linea0,linea1,linea2,linea3,s1,s2,Data_Out);

initial begin
linea0 = 64'd543;linea1=64'd250;linea2=64'd32;linea3=64'd810;
s1 = 2'b10;s2=2'b01; #10;
linea0 = 64'd543;linea1=64'd250;linea2=64'd32;linea3=64'd810;
s1 = 2'b10;s2=2'b00; #10;
linea0 = 64'd543;linea1=64'd250;linea2=64'd32;linea3=64'd8798798798795656810;
s1 = 2'b11;s2=2'b10; #10;





end
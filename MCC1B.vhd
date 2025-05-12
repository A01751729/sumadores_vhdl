--ANDRES MENDEZ CORTEZ A01751729
--MANCHESTER CARRY CHAIN DE 1 BIT
library ieee;
use ieee.std_logic_1164.all;
--entradas, numeros binarios, carry in
--salidas carry y suma
entity MCC1B is
	port(A,B,CIN: in std_logic;
			S,COUT: out std_logic);
end entity;

architecture RTL of MCC1B is 
	signal P,G: std_logic;
	
	begin
	--operaciones que realiza un full adder
	G<=A and B;
	P<=A xor B;
	S<=P xor CIN;
	--multiplexor para seleccionar el carry de salida
	with P select
		COUT<=CIN when '1',
				G  when '0';
	
end architecture; 
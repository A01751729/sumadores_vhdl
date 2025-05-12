--ANDRES MENDEZ CORTEZ A01751729
--CARRY SKIP ADDER BLOCK
library ieee;
use ieee.std_logic_1164.all;
--recibe el carry in y decide si propagarlo o no
entity CSKA_BLOCK is
	generic(N: integer:=8);
	port(A,B: in std_logic_vector(N-1 downto 0);
		  Cin: in std_logic;
		  PG,Cout: out std_logic;
		  S: out std_logic_vector(N-1 downto 0));
end entity;

architecture RTL of CSKA_BLOCK is
--hace uso de full adders
	component FA is
	port(A, B, Cin : in std_logic;
		  S, Co: out std_logic);
	end component;
	
	signal C: std_logic_vector(N downto 0);
	signal P: std_logic_vector(N-1 downto 0);
	
	begin
	C(0)<=Cin;
	--genera full adders para hacer la suma per se
	CSKA_B: for i in 0 to N-1 generate
			inst: FA port map(A(i),B(i),C(i),S(i),C(i+1));
			P(i)<= A(i)xor B(i);
		end generate;
	--decide si propagar el carry anterior o generar uno
	PoG: process (P)
		variable temp_PG: std_logic:='1';
		begin
		CSKA_PG: for i in 0 to N-1 loop
		temp_PG:=temp_PG and P(i);	
		end loop;
		PG<=temp_PG;
	end process;
	Cout<=C(N);
end architecture;

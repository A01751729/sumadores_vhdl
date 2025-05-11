--ANDRES MENDEZ C
--A01751729
--SUMADOR DE 4 BITS
library ieee;
use ieee.std_logic_1164.all;

--entidad
entity RCA is
	generic(N: integer:=4);
	port(A,B: in std_logic_vector(N-1 downto 0);
		 Cin: in std_logic;
		 S: out std_logic_vector(N-1 downto 0);
		 Cout: out std_logic);
end entity;

architecture RTL of RCA is
	
	component FA is
	port(A, B, Cin : in std_logic;
		  S, Co: out std_logic);
	end component;
	
	signal C: std_logic_vector(N downto 0);
	
	begin
	C(0)<=Cin;
	RCA: for i in 0 to N-1 generate
			inst: FA port map(A(i),B(i),C(i),S(i),C(i+1));
		end generate;
	COUT<=C(N);
end architecture;
--ANDRES MENDEZ C
--A01751729
--SUMA CON MCC
library ieee;
use ieee.std_logic_1164.all;

entity MCC8B is
--adaptar las entradas para la cantidad de bits
generic(N:integer:=8);
port(A,B: in std_logic_vector(N-1 downto 0);
		CIN: in std_logic;
		S: out std_logic_vector(N-1 downto 0);
		COUT: out std_logic);

end entity;

architecture RTL of MCC8B is
--importa la celula de un bit
	component MCC1B is
	port(A,B,CIN: in std_logic;
	     S, COUT:out std_logic);
	end component;
	
	signal C: std_logic_vector(N downto 0);
	
	begin
	C(0)<=CIN;
	--instanciacion de las celulas con un for
		MCC8B: for i in 0 to N-1 generate
			inst: MCC1B port map(A(i),B(i),C(i),S(i),C(i+1));
		end generate;
	COUT<=C(8);
end architecture;

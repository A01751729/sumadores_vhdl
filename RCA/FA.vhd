--ANDRES MENDEZ C
--A017517129
--SUMADOR COMPLETO CON CARRY IN

library ieee;
use ieee.std_logic_1164.all;

entity FA is
	port(A, B, Cin : in std_logic;
		  S, Co: out std_logic);
end entity;

architecture RTL of FA is
	--declaramos componentes
	component HA is
	port(A,B: in std_logic;--define AB como entradas logicas
	     S, Co:out std_logic);--define S y Co como salidas logicas
	end component;
	--declaramos señales necesarias
	signal SHA, CoHA, Co2: std_logic;
	
	begin
	--instanciamos
	I1: HA port map(A, B, SHA, CoHA);
	I2: HA port map(SHA, Cin, S, Co2);
	Co <= Co2 or CoHA;
end architecture;

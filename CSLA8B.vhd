--ANDRES MENDEZ CORTEZ A01751729
--CARRY SELECT ADDER
library ieee;
use ieee.std_logic_1164.all;
--entradas y salidas standard, cin esta pero no se usa
entity CSLA8B is
	port(A,B: in std_logic_vector(7 downto 0);
			Cin: in std_logic;
			S: out std_logic_vector(7 downto 0);
			Cout1,Cout2,Cout3: out std_logic);
end entity;

architecture RTL of CSLA8B is
--necesita ripple carry adder para duplicarlo 
	component RCA is
		generic(N: integer);
		port(A,B: in std_logic_vector(N-1 downto 0);
			 Cin: in std_logic;
			 S: out std_logic_vector(N-1 downto 0);
			 Cout: out std_logic);
	end component;
	
	signal S0,S1,S2: std_logic_vector(3 downto 0);
	signal C0,C1,C2: std_logic;
	
	begin
	--rca inical cin=0
	I0: RCA generic map(4) port map(A(3 downto 0),B(3 downto 0),Cin,S0,C0);
	--rca segunda ronda cin=0
	I1: RCA generic map(4) port map(A(7 downto 4),B(7 downto 4),'0',S1,C1);
	--rca segunda ronda cin=1
	I2: RCA generic map(4) port map(A(7 downto 4),B(7 downto 4),'1',S2,C2);
	S(3 downto 0)<=S0;
	--multiplexor para decidir cual usar
	S(7 downto 4)<=S2 when C0='1' else S1;
	Cout3<=C2 when C0='1' else C1;
	Cout1<=C0;
	Cout2<=C1;
end architecture;
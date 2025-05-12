--ANDRES MENDEZ CORTEZ A01751729
--CARRY SKIP ADDER DE 16 BITS
library ieee;
use ieee.std_logic_1164.all;
--variable por que se puede modificar los bits en teoria
entity CSKA_VARIABLE is
	port(A,B: in std_logic_vector(15 downto 0);
			CIN: in std_logic;
			COUT: out std_logic;
			S: out std_logic_vector(15 downto 0));
		
end entity;


architecture RTL of CSKA_VARIABLE is 
--ocupa las celulas de carry skip adder individuales
	component CSKA_BLOCK is
	generic(N: integer:=4);
	port(A,B: in std_logic_vector(N-1 downto 0);
		  Cin: in std_logic;
		  PG,Cout: out std_logic;
		  S: out std_logic_vector(N-1 downto 0));
	end component;
	signal C_skip: std_logic_vector(3 downto 0);
	signal C_gen: std_logic_vector(3 downto 0);
	signal C_prop:std_logic_vector(3 downto 0);
	--conecta las celulas una tras otra y genera varios multiplexores para decidir si generar o no
	begin
	I0: CSKA_BLOCK generic map(4) port map(A(3 downto 0),B(3 downto 0),CIN,C_skip(0),C_gen(0),S(3 downto 0));
	with C_skip(0) select
		C_prop(0)<=CIN when '1',
					C_gen(0) when '0';
					
	I1: CSKA_BLOCK generic map(4) port map(A(7 downto 4),B(7 downto 4),C_prop(0),C_skip(1),C_gen(1),S(7 downto 4));
	with C_skip(1) select
		C_prop(1)<=C_prop(0) when '1',
						C_gen(1) when '0';
						
	I2: CSKA_BLOCK generic map(4) port map(A(11 downto 8),B(11 downto 8),C_prop(1),C_skip(2),C_gen(2),S(11 downto 8));
	with C_skip(2) select
		C_prop(2)<=C_prop(1) when '1',
						C_gen(2) when '0';
						
	I3: CSKA_BLOCK generic map(4) port map(A(15 downto 12),B(15 downto 12),C_prop(2),C_skip(3),C_gen(3),S(15 downto 12));
	with C_skip(3) select
		C_prop(3)<=C_prop(2) when '1',
						C_gen(3) when '0';
	COUT<=C_prop(3);
end architecture;
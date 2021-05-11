--Top Module OnebitFullAdd
library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity OnebitFullAdd is
	port ( a, b, cin : in std_logic;
	      sum, carry: out std_logic);
end entity;


architecture OnebitFullAdd_arc of OnebitFullAdd is

	signal s1, c1, c2 : std_logic;
	
	component OnebitHalfAdd is
		port ( a, b : in std_logic;
				sum, carry: out std_logic);
	end component;
	
	component TwoByOneMux is
			port ( i : in std_logic_vector(1 downto 0); --2 i/p lines
					sel : in std_logic; --1 data select lines
					z : out std_logic); -- 1 output lines
	end component;
	
begin
   AdderInst1: OnebitHalfAdd port map(a => a, b => b, sum => s1, carry => c1);
	AdderInst2: OnebitHalfAdd port map(a => s1, b => cin, sum => sum, carry => c2);
	MInst1: TwoByOneMux port map(i(0) => c2, i(1) => c1, sel => c1, z => carry);
		
end architecture;
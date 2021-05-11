--Top Module OnebitHalfAdd
library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity OnebitHalfAdd is
	port ( a, b : in std_logic;
			sum, carry: out std_logic);
end entity;


architecture OnebitHalfAdd_arc of OnebitHalfAdd is

	signal p : std_logic;
	
	component TwoByOneMux is
			port ( i : in std_logic_vector(1 downto 0); --2 i/p lines
					sel : in std_logic; --1 data select lines
					z : out std_logic); -- 1 output lines
	end component;
	
begin
	MInst1: TwoByOneMux port map(i(0)=>'1', i(1)=>'0', sel=>a, z=>p);
	MInst2: TwoByOneMux port map(i(0)=>'0', i(1)=>a, sel=>b, z=>carry);
	MInst3: TwoByOneMux port map(i(0)=>a, i(1)=>p, sel=>b, z=>sum);
		
end architecture;
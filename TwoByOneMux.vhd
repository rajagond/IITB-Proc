--Module TwoByOneMux
library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity TwoByOneMux is
	port ( i : in std_logic_vector(1 downto 0); --2 i/p lines
			sel : in std_logic; --1 data select lines
			z : out std_logic); -- 1 output lines
end entity;

architecture TwoByOneMux_arc of TwoByOneMux is
begin
		z <= ((not sel) and i(0)) or (sel and i(1));
end architecture;
	
				
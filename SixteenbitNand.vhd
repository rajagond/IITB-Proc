--Top Module SixteenbitNand
library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity SixteenbitNand is
	port ( a, b : in std_logic_vector (15 downto 0);
		Sand : out std_logic_vector (15 downto 0);
end entity;

architecture SixteenbitNand_arc of SixteenbitNand is	
begin
	NandInst1To16: for i in 0 to 15 generate
		Sand(i) <= not(a(i) and b(i));
	end generate ;
		
end architecture;
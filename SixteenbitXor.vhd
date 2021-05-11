--Top Module SixteenbitXor
library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity SixteenbitXor is
	port ( a, b : in std_logic_vector (15 downto 0);
		Sxor : out std_logic_vector (15 downto 0);
end entity;

architecture SixteenbitXor_arc of SixteenbitXor is	
begin
	XorInst1To16: for i in 0 to 15 generate
		Sxor(i) <= (a(i) xor b(i));
	end generate ;
		
end architecture;
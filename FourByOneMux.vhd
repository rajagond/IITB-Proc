--Module FourByOneMux
library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity FourByOneMux is
	port ( i : in std_logic_vector(3 downto 0); --4 i/p lines
			sel : in std_logic_vector(1 downto 0); --2 data select lines
			z : out std_logic); -- 1 output lines
end entity;

architecture FourByOneMux_arc of FourByOneMux is
	component TwoByOneMux is
		port ( i : in std_logic_vector(1 downto 0); --2 i/p lines
				sel : in std_logic; --1 data select lines
				z : out std_logic); -- 1 output lines
	end component;
	Signal F1, F2: std_logic;
begin
	M1: TwoByOneMux port map(i(0) => i(0), i(1) => i(1), sel => sel(0), z => F1);
	M2: TwoByOneMux port map(i(0) => i(2), i(1) => i(3), sel => sel(0), z => F2);
	M3: TwoByOneMux port map(i(0) => F1, i(1) => F2, sel => sel(1), z => z);
end architecture;
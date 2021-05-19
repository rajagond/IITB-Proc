--Top Module SixteenbitFullAdd
library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity SixteenbitFullAdd is
	port ( a, b : in std_logic_vector (15 downto 0);
		cin: in std_logic;
		sum : out std_logic_vector (15 downto 0);
		carry: out std_logic);
end entity;


architecture SixteenbitFullAdd_arc of SixteenbitFullAdd is

	signal c_tmp : std_logic_vector(1 to 15) ;
	
	component OnebitFullAdd is
		port ( a, b, cin : in std_logic;
				sum, carry: out std_logic);
	end component;
	
begin
   	AdderInst1: OnebitFullAdd port map(a=>a(0), b=>b(0), cin=>cin, sum=>sum(0), carry=>c_tmp(1));
	
	Adder2To15: for i in 1 to 14 generate
			AdderInst_i: OnebitFullAdd port map(a => a(i), b => b(i), cin => c_tmp(i), sum => sum(i), carry => c_tmp(i+1));
			FA_i: fulladd PORT MAP ( C(i), A(i), B(i), Sum(i), C(i+1) ) ;
	end generate;
	
	AdderInst16: OnebitFullAdd port map(a => a(15), b => b(15), cin => c_tmp(15), sum => sum(15), carry => carry);
		
end architecture;
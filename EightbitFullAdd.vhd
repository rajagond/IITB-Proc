--Top Module OnebitHalAdderInstdd
library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;

entity EightbitFullAdd is
	port ( a, b : in std_logic_vector(7 downto 0);
			cin : in std_logic ;
			sum : out std_logic_vector(7 downto 0);
			carry: out std_logic);
end entity;


architecture EightbitFullAdd_arc of EightbitFullAdd is

	signal c : std_logic_vector( 6 downto 0);
	
	component OnebitFullAdd is
		port ( a, b, cin : in std_logic;
				sum, carry: out std_logic);
	end component;
	
begin
	AdderInst0: OnebitFullAdd port map (a=>a(0),b=>b(0),cin=>cin,sum=>sum(0),carry=>c(0));	
	AdderInst1: OnebitFullAdd port map (a=>a(1),b=>b(1),cin=>c(0),sum=>sum(1),carry=>c(1));
	AdderInst2: OnebitFullAdd port map (a=>a(2),b=>b(2),cin=>c(1),sum=>sum(2),carry=>c(2));
	AdderInst3: OnebitFullAdd port map (a=>a(3),b=>b(3),cin=>c(2),sum=>sum(3),carry=>c(3));
	AdderInst4: OnebitFullAdd port map (a=>a(4),b=>b(4),cin=>c(3),sum=>sum(4),carry=>c(4));
	AdderInst5: OnebitFullAdd port map (a=>a(5),b=>b(5),cin=>c(4),sum=>sum(5),carry=>c(5));
	AdderInst6: OnebitFullAdd port map (a=>a(6),b=>b(6),cin=>c(5),sum=>sum(6),carry=>c(6));
	AdderInst7: OnebitFullAdd port map (a=>a(7),b=>b(7),cin=>c(6),sum=>sum(7),carry=>carry);
		
end architecture;
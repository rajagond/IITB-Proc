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

	signal c_tmp : std_logic ;
	signal b_bar : std_logic_vector(15 downto 0);
	
	component EightbitFullAdd is
		port ( a, b : in std_logic_vector(7 downto 0);
				cin : in std_logic ;
				sum : out std_logic_vector(7 downto 0);
				carry: out std_logic);
	end component;
	
begin
	b_bar(0)<=cin xor b(0);
	b_bar(1)<=cin xor b(1);
	b_bar(2)<=cin xor b(2);
	b_bar(3)<=cin xor b(3);
	b_bar(4)<=cin xor b(4);
	b_bar(5)<=cin xor b(5);
	b_bar(6)<=cin xor b(6);
	b_bar(7)<=cin xor b(7);
	b_bar(8)<=cin xor b(8);
	b_bar(9)<=cin xor b(9);
	b_bar(10)<=cin xor b(10);
	b_bar(11)<=cin xor b(11);
	b_bar(12)<=cin xor b(12);
	b_bar(13)<=cin xor b(13);
	b_bar(14)<=cin xor b(14);
	b_bar(15)<=cin xor b(15);
	AdderInst1: EightbitFullAdd port map(a=> a(7 downto 0), b=> b_bar(7 downto 0), cin=>cin, sum=>sum(7 downto 0), carry=>c_tmp);
	AdderInst2: EightbitFullAdd port map(a=> a(15 downto 8), b=> b_bar(15 downto 8), cin=>c_tmp, sum=>sum(15 downto 8), carry=>carry);
		
end architecture;
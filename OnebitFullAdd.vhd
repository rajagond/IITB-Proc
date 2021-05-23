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
begin
	sum <= a xor b xor cin;
	carry <= (a and b) or (b and cin) or (cin and a);	
end architecture;
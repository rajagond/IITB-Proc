LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Decare a testbench.  Notice that the testbench does not have any
-- input or output ports.

entity TEST_ADD16 is
end TEST_ADD16;

-- Describes the functionality of the tesbench.

architecture TEST of TEST_ADD16 is 

	component SixteenbitFullAdd is
		port ( a, b : in std_logic_vector (15 downto 0);
			cin: in std_logic;
			sum : out std_logic_vector (15 downto 0);
			carry: out std_logic);
	end component;

	signal a, b		: STD_LOGIC_VECTOR(15 downto 0);
	signal sum		: STD_LOGIC_VECTOR(15 downto 0);
	signal carry, cin		: STD_LOGIC;
	
	begin
	U1: SixteenbitFullAdd port map (a,b,cin, sum, carry);
	
		process
		begin

		-- Case 1 that we are testing.
			cin <= '0';
			a <= x"0000";
			b <= x"0000";
			wait for 10 ns;
			assert ( sum = x"0000" )	report "Failed Case 1 - sum" severity error;
			assert ( carry = '0' )   report "Failed Case 1 - carry" severity error;
			wait for 40 ns;

		-- Case 2 that we are testing.
			cin <='0';
			a <= x"ffff";
			b <= x"ffff";
			wait for 10 ns;
			assert ( sum = x"fffe" )	report "Failed Case 2 - sum" severity error;
			assert ( carry = '1' )   report "Failed Case 2 - carry" severity error;
			wait for 40 ns;

		-- Case 3 that we are testing.
			cin <= '1';
			a <= x"0000";
			b <= x"0000";
			wait for 10 ns;
			assert ( sum = x"0000" )	report "Failed Case 3 - sum" severity error;
			assert ( carry = '1' )   report "Failed Case 3 - carry" severity error;
			wait for 40 ns;

		-- Case 4 that we are testing.
			cin <='1';
			a <= x"ffff";
			b <= x"ffff";
			wait for 10 ns;
			assert ( sum = x"0000" )	report "Failed Case 4 - sum" severity error;
			assert ( carry = '1' )   report "Failed Case 4 - carry" severity error;
			wait for 40 ns;
		end process;
END TEST;
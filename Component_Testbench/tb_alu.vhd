LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
  
ENTITY tb_alu IS
END tb_alu;
  
ARCHITECTURE behavior OF tb_alu IS
  
 -- Component Declaration for the Unit Under Test (UUT)
  
	 COMPONENT alu is
		port(ALU_A, ALU_B: in std_logic_vector(15 downto 0);
			 alu_control: in std_logic_vector(1 downto 0);
			 carry_flag_c, zero_flag_z, x: out std_logic;
			 ALU_C: out std_logic_vector(15 downto 0));
	end COMPONENT;
  
 
 -- Inputs
 signal inp_a : std_logic_vector(15 downto 0) := (others => '0');
 signal inp_b : std_logic_vector(15 downto 0) := (others => '0');
 signal sel : std_logic_vector(1 downto 0) := (others => '0');
 
 -- Outputs
 signal carry_flag_c, zero_flag_z, x: std_logic;
 signal out_alu : std_logic_vector(15 downto 0);
  
BEGIN
  
 -- Instantiate the Unit Under Test (UUT)
	 uut: alu PORT MAP (
		 ALU_A => inp_a,
		 ALU_B => inp_b,
		 alu_control => sel,
		 carry_flag_c => carry_flag_c,
		 zero_flag_z => zero_flag_z,
		 x => x,
		 ALU_C => out_alu
	 );
 
-- Stimulus process
 stim_proc: process
 begin
 -- hold reset state for 100 ns.
 wait for 100 ns;
 
 --insert stimulus here
 
 inp_a <= x"f00f";
 inp_b <= x"0ff0";
  
 sel <= "00";
 wait for 10 ns;
 sel <= "01";
 wait for 10 ns;
 sel <= "10";
 wait for 10 ns;
 
 inp_a <= x"ffff";
 inp_b <= x"ffff";
 sel <= "00";
 wait for 10 ns;
 sel <= "01";
 wait for 10 ns;

 inp_a <= x"0008";
 inp_b <= x"0000";
  sel <= "00";
 wait for 10 ns;
 inp_a <= x"0001";
 inp_b <= x"0000";
 sel <= "00";
 wait for 10 ns;
 wait;
 end process;
 
END ARCHITECTURE;

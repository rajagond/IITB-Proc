LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testbench IS
END testbench;
 
ARCHITECTURE behavior OF testbench IS 
    component IITB_Proc is
		port (clk, rst: in std_logic;
		PC_counter: out std_logic_vector(15 downto 0));
	end component;
   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   --Outputs
	signal PC_counter: std_logic_vector(15 downto 0);
   -- Clock period definitions
   constant clk_period : time := 10 ns;
	--signal res: STD_LOGIC_VECTOR (127 downto 0);
BEGIN
 -- Instantiate the for the multi-cycle MIPS Processor in VHDL
   uut: IITB_Proc PORT MAP (clk, reset, PC_counter );

   -- Clock process definitions
   clk_process :process
   begin
  clk <= '0';
  wait for clk_period/2;
  clk <= '1';
  wait for clk_period/2;
   end process;
   -- Stimulus process
   stim_proc: process
   begin  
      reset <= '1';
      wait for clk_period*100;
      reset <= '0';
      -- insert stimulus here 
		wait for clk_period*100;
		reset <= '1';
      wait;
   end process;

END;
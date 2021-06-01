LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_register_file IS
END tb_register_file;
 
ARCHITECTURE behavior OF tb_register_file IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    component register_file is
		 Port ( clk_in : in STD_LOGIC;
				  rst : in STD_LOGIC;
				  write_enable_in : in STD_LOGIC;
				  RF_D1 : out STD_LOGIC_VECTOR (15 downto 0); -- read_data1_out
				  RF_D2 : out STD_LOGIC_VECTOR (15 downto 0); -- read_data2_out
				  RF_D3 : in STD_LOGIC_VECTOR (15 downto 0); -- RF_D3_in
				  RF_A1 : in STD_LOGIC_VECTOR (2 downto 0); -- addr_read1_in
				  RF_A2 : in STD_LOGIC_VECTOR (2 downto 0); -- addr_read2_in
				  RF_A3 : in STD_LOGIC_VECTOR (2 downto 0));
	end component;
    

   --Inputs
   signal clk_in : std_logic := '0';
   signal rst : std_logic := '1';
   signal write_enable_in : std_logic := '0';
   signal RF_A1 : std_logic_vector(2 downto 0) := (others => '0');
   signal RF_A2 : std_logic_vector(2 downto 0) := (others => '0');
   signal RF_A3 : std_logic_vector(2 downto 0) := (others => '0');
   signal RF_D3 : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal RF_D1 : std_logic_vector(15 downto 0);
   signal RF_D2 : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: register_file PORT MAP (
          clk_in => clk_in,
          rst => rst,
          write_enable_in => write_enable_in,
          RF_A1 => RF_A1,
          RF_A2 => RF_A2,
          RF_A3 => RF_A3,
          RF_D3 => RF_D3,
          RF_D1 => RF_D1,
          RF_D2 => RF_D2
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk_in <= '0';
		wait for clk_period/2;
		clk_in <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold rst state for 100 ns.
		rst <= '1';

      wait for clk_period*10;

      -- insert stimulus here
		rst <= '0';
		-- INSERT DATA TO REGISTER
		write_enable_in 			<= '1';
		RF_A1 		<= (others => '0');
		RF_A2		<= (others => '0');
		RF_A3		<= "001";
		RF_D3 	<= (others => '1');
		
		wait for clk_period;

      -- INSERT DATA TO REGISTER
		write_enable_in 			<= '1';
		RF_A1 		<= (others => '0');
		RF_A2		<= (others => '0');
		RF_A3		<= "010";
		RF_D3 	<= x"0fff";
		
		wait for clk_period;
		
      -- INSERT DATA TO REGISTER
		write_enable_in 			<= '1';
		RF_A1 		<= (others => '0');
		RF_A2		<= (others => '0');
		RF_A3		<= "011";
		RF_D3 	<= x"00ff";
		
		wait for clk_period;

      -- INSERT DATA TO REGISTER
		write_enable_in 			<= '1';
		RF_A1 		<= (others => '0');
		RF_A2		<= (others => '0');
		RF_A3		<= "100";
		RF_D3 	<= x"0f0f";
		
		wait for clk_period;

         -- INSERT DATA TO REGISTER
		write_enable_in 			<= '1';
		RF_A1 		<= (others => '0');
		RF_A2		<= (others => '0');
		RF_A3		<= "101";
		RF_D3 	<= x"fff0";
		
		wait for clk_period;

		-- READ DATA FROM REGISTER
		write_enable_in 			<= '0';
		RF_A1 		<= "001";
		RF_A2		<= "010";
		RF_A3		<= (others => '0');
		RF_D3 	<= (others => '0');
		
		wait for clk_period;

		-- READ DATA FROM REGISTER
		write_enable_in 			<= '0';
		RF_A1 		<= "011";
		RF_A2		<= "100";
		RF_A3		<= (others => '0');
		RF_D3 	<= (others => '0');

		wait for clk_period;

		-- READ DATA FROM REGISTER
		write_enable_in 			<= '0';
		RF_A1 		<= "101";
		RF_A2		<= "000";
		RF_A3		<= (others => '0');
		RF_D3 	<= (others => '0');
      wait;
   end process;

END ARCHITECTURE;
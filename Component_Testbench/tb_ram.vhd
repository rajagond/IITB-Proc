LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
-- VHDL testbench code for the memory_asyncread
ENTITY tb_ram IS
END tb_ram;
 
ARCHITECTURE behavior OF tb_ram IS 
 
    -- Component Declaration for the memory_asyncread
 
    COMPONENT memory_asyncread
    PORT(
         mem_address_in : IN  std_logic_vector(15 downto 0);
         mem_data_in : IN  std_logic_vector(15 downto 0);
         write_enable_in : IN  std_logic;
         clk_in : IN  std_logic;
         mem_data_out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal mem_address_in : std_logic_vector(15 downto 0) := (others => '0');
   signal mem_data_in : std_logic_vector(15 downto 0) := (others => '0');
   signal write_enable_in : std_logic := '0';
   signal clk_in : std_logic := '0';

  --Outputs
   signal mem_data_out : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_in_period : time := 10 ns;
 
BEGIN
 
 -- Instantiate the memory_asyncread in VHDL
   uut: memory_asyncread PORT MAP (
          mem_address_in => mem_address_in,
          mem_data_in => mem_data_in,
          write_enable_in => write_enable_in,
          clk_in => clk_in,
          mem_data_out => mem_data_out
        );

   -- Clock process definitions
   clk_in_process :process
   begin
  clk_in <= '0';
  wait for clk_in_period/2;
  clk_in <= '1';
  wait for clk_in_period/2;
   end process;

   stim_proc: process
   begin  
	
  mem_address_in <= x"0000";
  write_enable_in <= '1';
  mem_data_in <= x"0000";
  -- start writing to RAM
  wait for 100 ns; 
  for i in 0 to 5 loop
  mem_address_in <= mem_address_in + x"0001";
  mem_data_in <= mem_data_in + x"0001";
      wait for clk_in_period*5;
  end loop;  
  write_enable_in <= '0'; 
  mem_address_in <= x"0000"; 
  wait for 100 ns; 
  -- start reading data from RAM 
  for i in 0 to 5 loop
  mem_address_in <= mem_address_in + x"0001";
      wait for clk_in_period*5;
  end loop;
  write_enable_in <= '0';
      wait;
   end process;

END ARCHITECTURE;
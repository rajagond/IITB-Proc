library work;
use work.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity register_file is
    Port ( clk_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           write_enable_in : in STD_LOGIC;
           RF_D1 : out STD_LOGIC_VECTOR (15 downto 0); -- read_data1_out
           RF_D2 : out STD_LOGIC_VECTOR (15 downto 0); -- read_data2_out
           RF_D3 : in STD_LOGIC_VECTOR (15 downto 0); -- write_data_in
           RF_A1 : in STD_LOGIC_VECTOR (2 downto 0); -- addr_read1_in
           RF_A2 : in STD_LOGIC_VECTOR (2 downto 0); -- addr_read2_in
           RF_A3 : in STD_LOGIC_VECTOR (2 downto 0));
end entity;

architecture Behavioral of register_file is
    type register_type is array (0 to 7 ) of std_logic_vector (15 downto 0);
    signal reg_array: register_type;
    begin
     process(clk_in,rst) 
     begin
     if(rst = '1') then
       reg_array(0) <= x"0010";
       reg_array(1) <= x"0001";
       reg_array(2) <= x"0001";
       reg_array(3) <= x"ffff";
       reg_array(4) <= x"0001";
       reg_array(5) <= x"0000";
       reg_array(6) <= x"0001";
       reg_array(7) <= x"0000";
     elsif(rising_edge(clk_in)) then
       if(write_enable_in ='1') then
        reg_array(to_integer(unsigned(RF_A3))) <= RF_D3;
       end if;
     end if;
     end process;
    
     RF_D1 <= reg_array(to_integer(unsigned(RF_A1)));
     RF_D2 <= reg_array(to_integer(unsigned(RF_A2)));
    
end architecture;
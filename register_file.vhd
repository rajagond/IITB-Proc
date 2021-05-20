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
           RF_A3 : in STD_LOGIC_VECTOR (2 downto 0)); -- addr_write_in
end entity;

architecture Behavioral of register_file is -- 8 Registers, 16 bits each
    type reg_array is array(0 to 7) of STD_LOGIC_VECTOR (15 downto 0);
    signal reg_file: reg_array := (others => x"0000"); -- assign all 0
    
begin
    process(clk_in)
    begin
        if rising_edge(clk_in) then -- Data written out or to registers
            if rst = '1' then
                reg_file  <= (others => x"0000");
            elsif write_enable_in ='1' then
                reg_file(to_integer(unsigned(RF_A3))) <= RF_D3;
            end if;
        end if;
    end process;
    RF_D1 <= reg_file(to_integer(unsigned(RF_A1)));
    RF_D2 <= reg_file(to_integer(unsigned(RF_A2)));
end architecture;
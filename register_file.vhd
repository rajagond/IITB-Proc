library work;
use work.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity register_file is
    Port ( clk_in : in STD_LOGIC;
           enable_in : in STD_LOGIC;
           write_enable_in : in STD_LOGIC;
           read_data1_out : out STD_LOGIC_VECTOR (15 downto 0);
           read_data2_out : out STD_LOGIC_VECTOR (15 downto 0);
           write_data_in : in STD_LOGIC_VECTOR (15 downto 0);
           addr_read1_in : in STD_LOGIC_VECTOR (2 downto 0);
           addr_read2_in : in STD_LOGIC_VECTOR (2 downto 0);
           addr_write_in : in STD_LOGIC_VECTOR (2 downto 0));
end register_file;

architecture Behavioral of register_file is -- 8 Registers, 16 bits each
    type reg_array is array(0 to 7) of STD_LOGIC_VECTOR (15 downto 0);
    signal reg_file: reg_array := (others => x"0000"); -- assign all 0
    
begin
    process(clk_in)
    begin
        if rising_edge(clk_in) then -- Data written out or to registers
            if write_enable_in ='1' then
                reg_file(to_integer(unsigned(addr_write_in))) <= write_data_in;
            end if;
        end if;
    end process;
    read_data1_out <= reg_file(to_integer(unsigned(addr_read1_in)));
    read_data2_out <= reg_file(to_integer(unsigned(addr_read2_in)));
end Behavioral;
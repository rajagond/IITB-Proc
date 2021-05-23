library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_asyncread is
    Port ( clk_in : in std_logic;
           write_enable_in : in std_logic;
           mem_address_in : in std_logic_vector(15 downto 0);
           mem_data_in : in std_logic_vector(15 downto 0);
           mem_data_out : out std_logic_vector(15 downto 0));
end entity;

architecture memory_asyncread_arc of memory_asyncread is

	type register_array is array(2047 downto 0) of std_logic_vector(15 downto 0);   -- defining a new type

	signal memory_ram: register_array := (
       0 => "1000000000000011", 1 => "1100000001000011", 2 => "1100001010000011", 3 => "1001001010000000",
	    others => x"0000" );
begin
    process(clk_in)
    begin
        if rising_edge(clk_in) then
            if(write_enable_in = '1') then
                memory_ram(to_integer(unsigned(mem_address_in))) <= mem_data_in; 
            end if;
        end if;
     end process;

	mem_data_out <= memory_ram(to_integer(unsigned(mem_address_in)));

end architecture;
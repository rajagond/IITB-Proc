library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;

entity muxQ41 is
    port(
        s       : in    std_logic_vector(1 downto 0);
        d0      : in    std_logic_vector(15 downto 0);
        d1      : in    std_logic_vector(15 downto 0);
        d2      : in    std_logic_vector(15 downto 0);
        d3      : in    std_logic_vector(15 downto 0);
        y       : out   std_logic_vector(15 downto 0));
end entity;

architecture muxQ41_arc of muxQ41 is

begin
  -- Your VHDL code defining the model goes here
  -- Selected signal assignment
  with s select y <= d0 when "00",
                     d1 when "01",
                     d2 when "10",
                     d3 when "11";
end architecture;
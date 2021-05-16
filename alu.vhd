library work;
use work.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity alu is
	port(S1, S2: in std_logic_vector(15 downto 0);
		 alu_control: in std_logic_vector(1 downto 0);
		 carry_flag_c, zero_flag_z, x: out std_logic;
		 alu_result: out std_logic_vector(15 downto 0));
end entity alu;

architecture Behavioral of alu is 
    component SixteenbitFullAdd is
        port ( a, b : in std_logic_vector (15 downto 0);
            cin: in std_logic;
            sum : out std_logic_vector (15 downto 0);
            carry: out std_logic);
    end component;

    component muxQ41 is
        port(
            s       : in    std_logic_vector(1 downto 0);
            d0      : in    std_logic_vector(15 downto 0);
            d1      : in    std_logic_vector(15 downto 0);
            d2      : in    std_logic_vector(15 downto 0);
            d3      : in    std_logic_vector(15 downto 0);
            y       : out   std_logic_vector(15 downto 0));
    end component;

    signal add_res, nand_res, xor_res : std_logic_vector(15 downto 0);
    signal add_res_carry, nand_res_carry, xor_res_carry : std_logic;
    signal res : std_logic_vector(15 downto 0);
begin
    AdderInst: SixteenbitFullAdd
        port map (
            a => S1, b => S2, cin => '0', sum => add_res, carry => add_res_carry); 
    nand_res <= S1 nand S2;
    nand_res_carry <= '0';

    xor_res <= S1 xor S2;
    xor_res_carry <= '0';

    MuxInst: muxQ41
    port map (
        s => alu_control, d0 => add_res, d1 => nand_res, d2 => xor_res, d3 => "0000000000000000", y => res
    );

    MuxInst2: muxQ41
    port map (
        s => alu_control, d0 => add_res_carry, d1 => nand_res_carry, d2 => xor_res_carry, d3 => '0', y => carry_flag
    );

    zero_flag <= '1' when res=x"0000" else '0';
    --doubt
    x <= not(res(3) and (not res(2)) and (not res(1)) and (not res(0)));
    alu_result <= res;

end Behavioral;
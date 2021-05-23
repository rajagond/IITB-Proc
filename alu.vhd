library work;
use work.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity alu is
	port(ALU_A, ALU_B: in std_logic_vector(15 downto 0);
		 alu_control: in std_logic_vector(1 downto 0);
		 carry_flag_c, zero_flag_z, x: out std_logic;
		 ALU_C: out std_logic_vector(15 downto 0));
end entity;

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
            d0      : in    std_logic_vector(16 downto 0);
            d1      : in    std_logic_vector(16 downto 0);
            d2      : in    std_logic_vector(16 downto 0);
            d3      : in    std_logic_vector(16 downto 0);
            y       : out   std_logic_vector(16 downto 0));
    end component;

    signal add_res, nand_res, xor_res : std_logic_vector(16 downto 0);
    signal add_res_carry, nand_res_carry, xor_res_carry : std_logic;
    signal res : std_logic_vector(16 downto 0);
begin
    AdderInst: SixteenbitFullAdd
        port map (
           a => ALU_A, b => ALU_B, cin => '0', sum => add_res(15 downto 0), carry => add_res(16)); 

    nand_res(0) <= ALU_A(0) nand ALU_B(0);
    nand_res(1) <= ALU_A(1) nand ALU_B(1);
    nand_res(2) <= ALU_A(2) nand ALU_B(2);
    nand_res(3) <= ALU_A(3) nand ALU_B(3);
    nand_res(4) <= ALU_A(4) nand ALU_B(4);
    nand_res(5) <= ALU_A(5) nand ALU_B(5);
    nand_res(6) <= ALU_A(6) nand ALU_B(6);
    nand_res(7) <= ALU_A(7) nand ALU_B(7);
    nand_res(8) <= ALU_A(8) nand ALU_B(8);
    nand_res(9) <= ALU_A(9) nand ALU_B(9);
    nand_res(10) <= ALU_A(10) nand ALU_B(10);
    nand_res(11) <= ALU_A(11) nand ALU_B(11);
    nand_res(12) <= ALU_A(12) nand ALU_B(12);
    nand_res(13) <= ALU_A(13) nand ALU_B(13);
    nand_res(14) <= ALU_A(14) nand ALU_B(14);
    nand_res(15) <= ALU_A(15) nand ALU_B(15);
    nand_res(16) <= '0';

    xor_res(0) <= ALU_A(0) xor ALU_B(0);
    xor_res(1) <= ALU_A(1) xor ALU_B(1);
    xor_res(2) <= ALU_A(2) xor ALU_B(2);
    xor_res(3) <= ALU_A(3) xor ALU_B(3);
    xor_res(4) <= ALU_A(4) xor ALU_B(4);
    xor_res(5) <= ALU_A(5) xor ALU_B(5);
    xor_res(6) <= ALU_A(6) xor ALU_B(6);
    xor_res(7) <= ALU_A(7) xor ALU_B(7);
    xor_res(8) <= ALU_A(8) xor ALU_B(8);
    xor_res(9) <= ALU_A(9) xor ALU_B(9);
    xor_res(10) <= ALU_A(10) xor ALU_B(10);
    xor_res(11) <= ALU_A(11) xor ALU_B(11);
    xor_res(12) <= ALU_A(12) xor ALU_B(12);
    xor_res(13) <= ALU_A(13) xor ALU_B(13);
    xor_res(14) <= ALU_A(14) xor ALU_B(14);
    xor_res(15) <= ALU_A(15) xor ALU_B(15);
    xor_res(16) <= '0';

    MuxInst: muxQ41
    port map (
        s => alu_control, d0 => add_res, d1 => nand_res, d2 => xor_res, d3 => "00000000000000000", y => res
    );

    zero_flag_z <= '1' when res(15 downto 0)=x"0000" else '0';
    carry_flag_c <= res(16);
    --doubt
    x <= not(res(3) and (not res(2)) and (not res(1)) and (not res(0)));
    ALU_C <= res(15 downto 0);

end architecture;
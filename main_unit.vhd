library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main_unit is
	port (clk, rst: in std_logic;
          output_main: out std_logic_vector(15 downto 0));
end entity;

architecture main_unit_arc of main_unit is
    component alu is
        port(ALU_A, ALU_B: in std_logic_vector(15 downto 0);
             alu_control: in std_logic_vector(1 downto 0);
             carry_flag_c, zero_flag_z, x: out std_logic;
             ALU_C: out std_logic_vector(15 downto 0));
    end component;

    component memory_asyncread is
        Port ( clk_in : in std_logic;
               write_enable_in : in std_logic;
               mem_address_in : in std_logic_vector(15 downto 0);
               mem_data_in : in std_logic_vector(15 downto 0);
               mem_data_out : out std_logic_vector(15 downto 0));
    end component;

    component register_file is
        Port ( clk_in : in STD_LOGIC;
              -- enable_in : in STD_LOGIC;
               write_enable_in : in STD_LOGIC;
               RF_D1 : out STD_LOGIC_VECTOR (15 downto 0); -- read_data1_out
               RF_D2 : out STD_LOGIC_VECTOR (15 downto 0); -- read_data2_out
               RF_D3 : in STD_LOGIC_VECTOR (15 downto 0); -- write_data_in
               RF_A1 : in STD_LOGIC_VECTOR (2 downto 0); -- addr_read1_in
               RF_A2 : in STD_LOGIC_VECTOR (2 downto 0); -- addr_read2_in
               RF_A3 : in STD_LOGIC_VECTOR (2 downto 0)); -- addr_write_in
    end component;
    
    type state_type is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20, S21, S22, S23, S24, S25, S26, S27);
	signal state: state_type;
    signal IP, IR: std_logic_vector(15 downto 0); -- 16 bit Instruction Pointer and Instruction Register
    signal tmp1, tmp2, tmp3, tmp4, tmp5 : std_logic_vector(15 downto 0);
    signal rf_a1, rf_a2, rf_a3 : std_logic_vector(2 downto 0);
    signal mem_add, mem_datain, mem_dataout, alu_a, alu_b, alu_c, rf_d1, rf_d2, rf_d3 : std_logic_vector(15 downto 0);
    signal alu_con : std_logic_vector(1 downto 0);
    signal carry_flag_tc, zero_flag_tz, rf_w, mem_w, ALU_carry, ALU_zero, ALU_count8 : std_logic;
begin
    MemInst : memory_asyncread port map (
        clk_in => clk, write_enable_in => mem_w, mem_address_in => mem_add, mem_data_in => mem_datain, mem_data_out => mem_dataout);
    
    AluInst : alu port map (
        ALU_A=> alu_a, ALU_B=>alu_b, alu_control=>alu_con, carry_flag_c => ALU_carry, zero_flag_z=> ALU_zero, x=>ALU_count8, ALU_C=> alu_c
    );

    RegInst : register_file port map (
        clk_in => clk, write_enable_in => rf_w, RF_D1 => rf_d1, RF_D2 => rf_d2, RF_D3 => rf_d3, RF_A1 => rf_a1, RF_A2 => rf_a2, RF_A3 => rf_a3);

    process(clk, state)

    variable next_IP, tmp1_var, tmp2_var, tmp3_var, tmp4_var, tmp5_var, IR_var : std_logic_vector(15 downto 0);
    variable next_state : state_type;
    variable tz_var, tc_var : std_logic;
    begin
    
    next_state :=  state;
    next_IP := IP;
    tmp4_var := tmp4;
    tmp1_var := tmp1;
    tmp2_var := tmp2;
    tmp3_var := tmp3;
    tmp5_var := tmp5;
    tz_var := zero_flag_tz;
    tc_var := carry_flag_tc
    --IR_var := IR;

    case( state ) is
        
            when S0 =>
                mem_w <='0';
                --rf_w <= '0';
                mem_add <= IP;
                --IR_var := mem_dataout;
                IR <= mem_dataout;
                case (IR(15 downto 12)) is
                    when "0000" => 
                        if (IR(1 downto 0) = "00") then   
                            next_state := S1;
                        elsif (IR(1 downto 0)= "10" and carry_flag_tc = '1') then
                            next_state := S1;
                        elsif (IR(1 downto 0)= "01" and zero_flag_tz = '1') then
                            next_state := S1;
                        else
                            next_state := S4;
                        end if;
                    when "0001" =>
                        next_state := S5;
                    when "0010" =>
                        if (IR(1 downto 0) = "00") then   
                            next_state := S1;
                        elsif (IR(1 downto 0)= "10" and carry_flag_tc = '1') then
                            next_state := S1;
                        elsif (IR(1 downto 0)= "01" and zero_flag_tz = '1') then
                            next_state := S1;
                        else
                            next_state := S4;
                        end if;
                    when "0011" =>
                        next_state := S8;
                    when "0100" =>
                        next_state := S1;
                    when "0101" =>
                        next_state := S1;
                    when "0110" =>
                        next_state := S15;
                    when "0111" =>
                        next_state := S15;
                    when "1100" =>
                        next_state := S22;
                    when "1000" =>
                        next_state := S25;
                    when "1001" =>
                        next_state := S25;
                    when others =>
                        null;
                end case;
            
            when S1 =>
                --mem_w <= '0';
                rf_w <= '0'; --read
                rf_a1 <= IR(11 downto 9);
                rf_a2 <= IR(8 downto 6);
                tmp1_var := rf_d1; 
                tmp2_var := rf_d2;
                
                case (IR(15 downto 12)) is
                    when "0000" =>
                        next_state := S2;
                    when "0010" =>
                        next_state := S7;
                    when "0100" =>
                        next_state := S10;
                    when "0101" =>
                        next_state := S13;
                    when others =>
                        null;
                end case;

            when S2 =>
                --mem_w <= '0';
                alu_a <= tmp1;
                alu_b <= tmp2;
                alu_con <= "00";
                tmp3_var <= alu_c; 
                --rf_w <= '1';
                tc_var := ALU_carry;
                tz_var := ALU_zero;
                case (IR(15 downto 12)) is
                    when "0000" =>
                        next_state := S3;
                    when "0001" =>
                        next_state := S6;
                    when others =>
                        null;
                end case;

            when S3 =>
                --mem_w <='0';
                rf_w <= '1'; -- write
                rf_d3 <= tmp3;
                rf_a3 <= IR(5 downto 3) ;
                next_state := S4;

            when S4 =>
                --rf_w <= '0';
                --mem_w <= '0';
                alu_a <= IP;
                alu_b <= x"0001";
                alu_con<="00";
                next_IP := alu_c;

                next_state := S0;

            when S5 =>
                rf_w <= '0';
                --mem_w<='1';
                rf_a1 <= IR(11 downto 9); 
                tmp1_var := rf_d1;

                tmp2_var := IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5 downto 0);

                next_state := S2;

            when S6 =>
                --mem_w<='0';
                rf_w <= '1';
                rf_d3 <= tmp3;
                rf_a3 <= IR(8 downto 6);
                next_state := S4;
            
            when S7 =>
                --rf_w <= '0';
                --mem_w<='0';
                alu_a <= tmp1; 
                alu_b <= tmp2;
                alu_con <= "01";
                tmp3_var := alu_c; 
                tz_var <= ALU_zero;

                next_state := S3;


            when S8 =>
                -- rf_w <= '0';
                -- mem_w <= '0';
                tmp1_var(15 downto 7) := IR(8 downto 0);
                tmp1_var(6 downto 0) := "0000000";

                next_state:=S9;

            when S9 =>
                -- mem_w <= '0';
                rf_w <= '1';
                rf_d3 <= tmp1;
                rf_a3 <= IR(11 downto 9);

                next_state := S4;

            when S10 =>
                -- rf_w <= '0';
                -- mem_w <= '0';
                alu_a <= tmp2;
                alu_b := IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5 downto 0);
                
                alu_con <= "00";
                tmp3_var:= alu_c;
                tz_var := ALU_zero;

                next_state := S11;

            when S11 =>
                -- rf_w <= '0';
                mem_w <='0';

                mem_add <= tmp3;
                tmp3_var := mem_dataout;

                next_state:= S12;

            when S12 =>
                -- mem_w <='0';
                rf_w <= '1';
                rf_d3 <= tmp3;
                rf_a3 <= IR(11 downto 9);
                next_state := S4;

            when S13 =>
                --rf_w <= '0';
                -- mem_w <='0';
                alu_a <=tmp2;
                alu_b <= IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5 downto 0);

                alu_con <= "00";
                tmp3_var := alu_c;
                next_state := S14;

            when S14 =>
                --rf_w <= '0';
                mem_w <= '1'; -- memory write
                mem_add <= tmp3;
                mem_datain <= tmp1;
                next_state := S4;

            when S15 =>
                rf_w <= '0';
                -- mem_w <= '0';
                rf_a1 <= IR(11 downto 9);
                tmp1_var := rf_d1;
                tmp2_var := x"0000";
                next_state := S16;

            when S16 =>
                -- rf_w <= '0';
                -- mem_w <='0';
                alu_a <= tmp1;
                alu_b <= tmp2;
                alu_con <= "00";
                tmp3_var := alu_c;

                if (IR(15 downto 12) = "0110") then
                    next_state := S17;
                elsif (IR(15 downto 12) = "0111") then
                    next_state := S20;
                end if;

            when S17 =>
                -- rf_w <= '0';
                mem_w <= '0';
                mem_add <= tmp3;
                tmp4_var := mem_dataout;

                next_state := S18;

            when S18 =>
                -- mem_w <= '0';
                rf_w <= '1';
                rf_a3 <= tmp2(2 downto 0);
                rf_d3 <= tmp4;
                tmp5_var := tmp2;

                next_state:=S19;

            when S19 =>
                -- rf_w <= '0';
                -- mem_w<='0';
                alu_a <= tmp5;
                alu_b <= x"0001";
                -- ALU_A<=tmp5;
                alu_con <="00";
                tmp2_var:= alu_c;

                if ( ALU_count8 ='0') then
                    next_state := S4;
                elsif ( ALU_count8 ='1') then
                    next_state := S16;
                end if;

            when S20 =>
                rf_w <= '0';
                -- mem_w <='0';
                rf_a2 <= tmp2(2 downto 0);
                tmp4_var := rf_d2;

                next_state := S21;

            when S21 =>
                -- rf_w <= '0';
                mem_w <= '1';
                mem_add <=tmp3;
                mem_datain <= tmp4;
                tmp5_var := tmp2;
                next_state:=S19;

            when S22 =>
                rf_w <= '0';
                -- mem_w <='0';
                rf_a1 <= IR(11 downto 9);
                rf_a2 <= IR(8 downto 6);
                tmp1_var <= rf_d1;
                tmp2_var <= rf_d2;
                alu_a <= IP;
                alu_b <= IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5 downto 0);
                alu_con <= "00";
                tmp3_var:= alu_c;

                next_state:=S23;

            when S23 =>
                -- rf_w <= '0';
                -- mem_w<='0';
                alu_a <=tmp1;
                alu_b <=tmp2;
                alu_con <="10";
                tmp4_var:= alu_c;

                if( ALU_zero = '0') then
                    next_state := S4;
                elsif (ALU_Z='1') then
                    next_state:= S24;
                end if;

            when S24 =>
                -- rf_w <= '0';
                -- mem_w <='0';
                next_IP := tmp3;
                next_state := S0;

            when S25 =>
                --mem_w <='0';
                rf_w <= '1';
                rf_a3 <= IR(11 downto 9);
                rf_d3 <= IP;

                if (IR(15 downto 12) = "1000") then
                    next_state := S26;
                elsif (IR(15 downto 12)="1001") then
                    next_state := S27;
                end if;

            when S26 =>
                -- rf_w <= '0';
                -- mem_w <= '0';
                alu_a <= IP;
                alu_b <= IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(5) & IR(8 downto 0);
                alu_con <= "00";
                next_IP := alu_c;

                next_state := S0;

            when S27 =>
                -- rf_w <= '0';
                -- mem_w <='0';
                next_IP := tmp2;
                next_state := S0;

            when others =>
                null;
        end case ;

        tmp1 <= tmp1_var;
        tmp2 <= tmp2_var;
        tmp3 <= tmp3_var;
        tmp4 <= tmp4_var;
        tmp5 <= tmp5_var;
        --IR <= IR_var;
        carry_flag_tc <= tc_var; zero_flag_tz <= tz_var;

        if(rising_edge(clk)) then
            if (rst = '1') then
                IP <= x"0000";
                state <= S0;
            else
                state <= next_state;
                IP <= next_IP;
            end if;
        end if;
    end process;

end architecture;
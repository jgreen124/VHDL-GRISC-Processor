----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/28/2024 04:58:46 PM
-- Design Name: 
-- Module Name: alu_tester_tb - alu_tester_tb_arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_tester_tb is
--  Port ( );

end alu_tester_tb;

architecture alu_tester_tb_arch of alu_tester_tb is


signal tb_clk : std_logic;
signal tb_sw : std_logic_vector(3 downto 0);
signal tb_btn : std_logic_vector(3 downto 0);
signal tb_output: std_logic_vector(15 downto 0);
component alu_tester is
    Port ( in1, in2 : in STD_LOGIC_VECTOR (3 downto 0);
         clk : in STD_LOGIC;
         output : out STD_LOGIC_VECTOR (15 downto 0));
end component alu_tester;

component debouncer is
        port(
            in0 : in STD_LOGIC;
            out0 : out STD_LOGIC;
            clk : in STD_LOGIC);
    end component debouncer;

begin

clk_gen_proc : process
    begin
        wait for 4ns;
        tb_clk <= '1';
        wait for 4ns;
        tb_clk <= '0';
end process clk_gen_proc;

btn: process
    begin
    tb_btn <="0101";
    wait for 120ms;
    tb_btn <= "0011";
    wait for 120ms;
    tb_btn <= "1011"; --reset;
    wait for 120 ms;
    tb_btn <= "0111";
    wait for 120ms;
end process;

vary_sw : process
begin
    wait for 24ms;
    tb_sw <= "0011";
    wait for 24ms;
    tb_sw <= "0111";
    wait for 24ms;
    tb_sw <= "0010";
    wait for 24ms;
    tb_sw <= "1011";

end process; 


dut : alu_tester port map(

    in1 => tb_btn,
    in2 => tb_sw,
    clk => tb_clk,
    output => tb_output
);
end alu_tester_tb_arch;

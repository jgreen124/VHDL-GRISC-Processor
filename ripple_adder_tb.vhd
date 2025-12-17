----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2024 05:06:33 PM
-- Design Name: 
-- Module Name: ripple_adder_tb - ripple_adder_tb_arch
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ripple_adder_tb is
--  Port ( );
end ripple_adder_tb;

architecture ripple_adder_tb_arch of ripple_adder_tb is

component ripple_adder 
    port(
       A,B : in STD_LOGIC_VECTOR (3 downto 0);
       S_vec : out STD_LOGIC_VECTOR (3 downto 0);
       C0 : in STD_LOGIC;
       C4 : out std_logic);
end component ripple_adder;

signal tb_A, tb_B : std_logic_vector(3 downto 0);
signal tb_S : std_logic_vector(3 downto 0);
signal tb_C_in : std_logic;
signal tb_C_out : std_logic;
begin


varyA : process
begin
    tb_A <= "0101";
    wait for 5ms;
    tb_A <= "0111";
    wait for 5ms;
    tb_A <= "1001";
    wait for 5ms;  
end process varyA;

varyB : process
begin
    tb_B <= "1100";
    wait for 7ms;
    tb_B <= "0100";
    wait for 7ms;
    tb_B <= "0011";
    wait for 7ms;
end process varyB;


varyC : process
begin
    tb_C_in <= '1';
    wait for 9ms;
    tb_C_in <= '0';
    wait for 9ms;
end process varyC;



dut : ripple_adder port map(
    A => tb_A,
    B => tb_B,
    S_vec => tb_S,
    C0 => tb_C_in,
    C4 => tb_C_out
    
);

end ripple_adder_tb_arch;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2024 08:27:02 PM
-- Design Name: 
-- Module Name: my_alu_tb - my_alu_tb_arch
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

entity my_alu_tb is
--  Port ( );
end my_alu_tb;

architecture my_alu_tb_arch of my_alu_tb is
signal tb_clk : std_logic;
signal tb_A : std_logic_vector(15 downto 0) := "0000000000000001";
signal tb_B : std_logic_vector(15 downto 0) := "0100010101010101";
signal tb_OPCODE: std_logic_vector(3 downto 0) := "0000";
signal tb_output: std_logic_vector(15 downto 0);
component my_alu is
    Port(
         A, B : in STD_LOGIC_VECTOR (15 downto 0);
         OPCODE : in STD_LOGIC_VECTOR (3 downto 0);
         clk : in std_logic;
         output : out STD_LOGIC_VECTOR (15 downto 0));

end component;

begin
clk_gen_proc : process
    begin
        wait for 4ns;
        tb_clk <= '1';
        wait for 4ns;
        tb_clk <= '0';
end process clk_gen_proc;

vary_a : process
begin
    wait for 12ms;
    tb_A <= std_logic_vector(unsigned(tb_A) + 1);
    wait for 12ms;
    if(unsigned(tb_A) = 15) then
        tb_A <= "0000000000000001";
    end if;
end process;

vary_b : process
begin
    wait for 24ms;
    tb_B <= std_logic_vector(unsigned(tb_B) + 1);
    wait for 24ms;
    if(unsigned(tb_B) = 15) then
        tb_B <= "0100010101010101";
    end if;
end process;    
        
vary_OPCODE : process
begin
    wait for 8ms;
    tb_OPCODE <= std_logic_vector(unsigned(tb_OPCODE) + 1);
    wait for 8ms;
    if(unsigned(tb_OPCODE) = 15) then
        tb_OPCODE <= "0000";
    end if;
end process; 

dut : my_alu port map(

    A => tb_A,
    B => tb_B,
    OPCODE => tb_OPCODE,
    clk => tb_clk,
    output => tb_output
);
end my_alu_tb_arch;



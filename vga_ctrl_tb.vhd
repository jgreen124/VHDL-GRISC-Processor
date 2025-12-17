----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2024 06:22:08 PM
-- Design Name: 
-- Module Name: vga_ctrl_tb - vga_ctrl_tb_arch
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

entity vga_ctrl_tb is
    --  Port ( );
end vga_ctrl_tb;

architecture vga_ctrl_tb_arch of vga_ctrl_tb is


    signal clk : std_logic;
    signal clk_en : std_logic;
    signal hcount : std_logic_vector(9 downto 0);
    signal vcount : std_logic_vector(9 downto 0);
    signal vid : std_logic;
    signal vs : std_logic;
    signal hs : std_logic;
    
    component vga_ctrl is
        Port(
            signal clk : in std_logic;
            signal clk_en : in std_logic;
            signal vid : out std_logic;
            signal hcount, vcount : out std_logic_vector(9 downto 0);
            signal vs : out std_logic;
            signal hs : out std_logic
        );
    end component vga_ctrl;

    
begin

dut : vga_ctrl port map(
    clk => clk,
    clk_en => clk_en,
    hcount => hcount,
    vcount => vcount,
    vid => vid,
    vs => vs,
    hs => hs
);

clk_gen : process begin
    clk <= '0';
    wait for 4 ns;
    clk <= '1';
    wait for 4 ns;
end process clk_gen;

clk_en_gen : process begin
    clk_en <= '1';
    wait for 8 ns;
    clk_en <= '1';
    wait for 8 ns;
end process clk_en_gen;




end vga_ctrl_tb_arch;

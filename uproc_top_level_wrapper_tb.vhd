----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2024 10:05:50 PM
-- Design Name: 
-- Module Name: uproc_top_level_wrapper_tb - Behavioral
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

entity uproc_top_level_wrapper_tb is
--  Port ( );
end uproc_top_level_wrapper_tb;

architecture Behavioral of uproc_top_level_wrapper_tb is

component toplevelproc_wrapper is
  port (
    RXD : out STD_LOGIC;
    TXD : in STD_LOGIC;
    btn_0 : in STD_LOGIC;
    clk : in STD_LOGIC;
    vga_b : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_g : out STD_LOGIC_VECTOR ( 5 downto 0 );
    vga_hs : out STD_LOGIC;
    vga_r : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_vs : out STD_LOGIC
  );
end component;

signal RXD : std_logic;
signal TXD : std_logic;
signal btn_0 : std_logic;
signal clk : std_logic;
signal vga_b : std_logic_vector(4 downto 0);
signal vga_g : std_logic_vector(5 downto 0);
signal vga_hs : std_logic;
signal vga_r : std_logic_vector(4 downto 0);
signal vga_vs : std_logic;



begin

process begin
clk <= '1';
wait for 4 ns;
clk <= '0';
wait for 4 ns;
end process;

DUT : toplevelproc_wrapper port map(
RXD => RXD,
TXD => TXD,
btn_0 => btn_0,
clk => clk,
vga_b => vga_b,
vga_g => vga_g,
vga_hs => vga_hs,
vga_r => vga_r,
vga_vs => vga_vs
);
end Behavioral;

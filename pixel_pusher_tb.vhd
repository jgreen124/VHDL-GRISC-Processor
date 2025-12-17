----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2024 11:54:09 PM
-- Design Name: 
-- Module Name: pixel_pusher_tb - pixel_pusher_tb_arch
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

entity pixel_pusher_tb is
    --  Port ( );
end pixel_pusher_tb;

architecture pixel_pusher_tb_arch of pixel_pusher_tb is

    component pixel_pusher is
        Port ( clk, clk_en, VS : in STD_LOGIC;
             pixel : in STD_LOGIC_VECTOR (15 downto 0);
             hcount : in STD_LOGIC_VECTOR (6 downto 0);
             vid : in STD_LOGIC;
             R, B : out STD_LOGIC_VECTOR (4 downto 0);
             G : out STD_LOGIC_VECTOR (5 downto 0);
             addr : out STD_LOGIC_VECTOR (11 downto 0));
    end component pixel_pusher;

    component vga_ctrl is
        Port (
            signal clk : in std_logic;
            signal clk_en : in std_logic;
            signal hcount, vcount : out std_logic_vector(6 downto 0);
            signal vid : out std_logic;
            signal hs, vs  : out std_logic);
    end component vga_ctrl;

    signal clk, clk_en, VS :  STD_LOGIC;
    signal pixel :  STD_LOGIC_VECTOR (15 downto 0) := (others => '1');
    signal hcount :  STD_LOGIC_VECTOR (6 downto 0);
    signal vid :  STD_LOGIC;
    signal R, B :  STD_LOGIC_VECTOR (4 downto 0);
    signal G :  STD_LOGIC_VECTOR (5 downto 0);
    signal addr :  STD_LOGIC_VECTOR (11 downto 0);
    signal vcount : std_logic_vector(6 downto 0);
    signal hs : std_logic;
begin


    dut : pixel_pusher port map(
            clk => clk,
            clk_en => clk_en,
            VS => VS,
            pixel => pixel,
            hcount => hcount,
            vid => vid,
            R => R,
            B => B,
            G => G,
            addr => addr
        );

    vga : vga_ctrl port map (
            clk => clk,
            clk_en => clk_en,
            hcount => hcount,
            vcount => vcount,
            vid => vid,
            hs => hs,
            vs => vs
        );
        
    clock_gen : process begin
        clk <= '1';
        wait for 4 ns;
        clk <= '0';
        wait for 4 ns;
    end process clock_gen;

    clock_en_gen : process begin
        clk_en <= '1';
        wait for 8 ns;
        clk_en <= '0';
        wait for 8 ns;
    end process clock_en_gen;

end pixel_pusher_tb_arch;

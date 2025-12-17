----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2024 11:45:36 PM
-- Design Name: 
-- Module Name: pixel_pusher - pixel_pusher_arch
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

entity pixel_pusher is
    Port ( clk, clk_en, VS : in STD_LOGIC := '0';
         pixel : in STD_LOGIC_VECTOR (15 downto 0);
         hcount : in STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
         vid : in STD_LOGIC := '0';
         R, B : out STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
         G : out STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
         addr : out STD_LOGIC_VECTOR (11 downto 0));
end pixel_pusher;

architecture pixel_pusher_arch of pixel_pusher is

    signal addr_Reg : std_logic_vector(11 downto 0) := (others => '0');

begin

    addr <= addr_Reg;

    addr_proc : process(clk) begin
        if(rising_edge(clk)) then
            if(VS = '0') then
                addr_Reg  <= (others => '0');
            end if;
            if(clk_en = '1' and vid = '1' and unsigned(hcount)<480) then
                addr_Reg <= std_logic_vector(unsigned(addr_Reg)+1);
                R <= pixel(15 downto 11);
                G <= pixel(10 downto 5);
                B <= pixel(4 downto 0);
            elsif(clk_en = '1' and vid = '1' and unsigned(hcount)>=480) then
                R <= (others => '0');
                B <= (others => '0');
                G <= (others => '0');
            elsif(clk_en = '0') then
                R <= (others => '0');
                B <= (others => '0');
                G <= (others => '0');
            end if;
        end if;
    end process addr_proc;
end pixel_pusher_arch;

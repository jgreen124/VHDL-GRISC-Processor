----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2024 09:49:56 PM
-- Design Name: 
-- Module Name: clock_div_uart - Behavioral
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

entity clock_div_uart is

port (
  clk : in std_logic;
  en  : out std_logic
);
end clock_div_uart;

architecture Behavioral of clock_div_uart is
  signal count : std_logic_vector (26 downto 0) := (others => '0');
begin


  
  process(clk) 
  begin
    if rising_edge(clk) then
        if (unsigned(count) < 1084) then
          count <= std_logic_vector( unsigned(count) + 1 );
          en <= '0';
        else    
          count <= (others => '0');
          en <= '1';
        end if;
   end if;     
  end process;




end Behavioral;

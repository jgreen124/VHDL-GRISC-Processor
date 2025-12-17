----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2024 12:35:04 PM
-- Design Name: 
-- Module Name: framebuffer - Behavioral
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

entity framebuffer is
    Port ( clk1, en1, en2, ld : in STD_LOGIC;
         addr1, addr2 : in STD_LOGIC_VECTOR (11 downto 0);
         wr_en1 : in STD_LOGIC;
         din1 : in STD_LOGIC_VECTOR (15 downto 0);
         dout1, dout2 : out STD_LOGIC_VECTOR (15 downto 0));
end framebuffer;

architecture framebuffer_arch of framebuffer is







    type mem_type is array (0 to 4095) of std_logic_vector(15 downto 0);
    signal ram : mem_type;
    
begin


    process(clk1)
    begin

        if (rising_edge(clk1)) then
            if(wr_en1 = '1') then
                ram(to_integer(unsigned(addr1))) <= din1;
            end if;
            --if(ld = '1') then
                dout1 <= ram(to_integer(unsigned(addr1)));
            --end if;
        end if;

    end process;

    process(clk1)
    begin

        if (rising_edge(clk1)) then
            if(wr_en1 = '1') then
                ram(to_integer(unsigned(addr2))) <= din1;
            end if;
            --if(ld = '1') then
                dout2 <= ram(to_integer(unsigned(addr2)));
            --end if;
        end if;

    end process;




end framebuffer_arch;

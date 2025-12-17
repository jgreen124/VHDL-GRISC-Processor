----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2024 04:34:14 PM
-- Design Name: 
-- Module Name: adder - adder_arch
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

entity adder is
    Port ( A, B, C_in : in STD_LOGIC;
           S, C_out : out STD_LOGIC);
end adder;

architecture adder_arch of adder is


signal ABXOR : std_logic;
signal CinAND : std_logic;
signal ABAND : std_logic;
begin

ABXOR <= A XOR B;
S <= C_in XOR ABXOR;
CinAND <= C_in AND ABXOR;
ABAND <= A AND B;
C_out <= CinAND or ABAND;
end adder_arch;

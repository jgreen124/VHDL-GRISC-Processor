----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2024 04:45:01 PM
-- Design Name: 
-- Module Name: ripple_adder - ripple_adder_tb
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

entity ripple_adder is
    Port ( A,B : in STD_LOGIC_VECTOR (3 downto 0);
           S_vec : out STD_LOGIC_VECTOR (3 downto 0);
           C0 : in STD_LOGIC;
           C4 : out std_logic); 
end ripple_adder;

architecture ripple_adder_tb of ripple_adder is


component adder
port(
    A, B, C_in : in std_logic;
    S : out std_logic;
    C_out : out std_logic);
end component adder;
signal C1, C2, C3 : std_logic; 
begin

U0 : adder port map(
    C_out => C1,
    A => A(0),
    B => B(0),
    C_in => C0,
    S => S_vec(0)
    );
    
U1 : adder port map(
    C_out => C2,
    A => A(1),
    B => B(1),
    C_in => C1,
    S => S_vec(1)
    );
    
U2 : adder port map(
    C_out => C3,
    A => A(2),
    B => B(2),
    C_in => C2,
    S => S_vec(2)
    );
    
U3 : adder port map(
    C_out => C4,
    A => A(3),
    B => B(3),
    C_in => C3,
    S => S_vec(3)
    );

end ripple_adder_tb;

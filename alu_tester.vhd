----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2024 09:32:50 PM
-- Design Name: 
-- Module Name: alu_tester - alu_tester_tb
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

entity alu_tester is
    Port ( in1, in2 : in STD_LOGIC_VECTOR (3 downto 0);
         clk : in STD_LOGIC;
         output : out STD_LOGIC_VECTOR (3 downto 0));
end alu_tester;

architecture alu_tester_arch of alu_tester is

    component debouncer is
        port(
            in0 : in STD_LOGIC;
            out0 : out STD_LOGIC;
            clk : in STD_LOGIC);
    end component debouncer;

    component my_alu is
        Port ( A, B : in STD_LOGIC_VECTOR (3 downto 0);
             OPCODE : in STD_LOGIC_VECTOR (3 downto 0);
             clk : in std_logic;
             output : out STD_LOGIC_VECTOR (3 downto 0));
    end component my_alu;
    signal debounce_out : std_logic_vector(3 downto 0);
    signal A_internal, B_internal, OPCODE_internal : std_logic_vector(3 downto 0);


begin

process(clk)
begin
    if (rising_edge (clk)) then
        if(debounce_out(2) = '1') then
            OPCODE_internal <= in2;
        end if;
        if(debounce_out(1) = '1') then
            A_internal <= in2;
        end if;
        if(debounce_out(0) = '1') then
            B_internal <= in2;
        end if;
        if(debounce_out(3) = '1') then
            B_internal <= "0000";
            A_internal  <= "0000";
            OPCODE_internal <= "0000";
        end if;
    end if;
end process;

    U0 : debouncer port map(
    in0 => in1(0),
    clk => clk,
    out0 => debounce_out(0)
    
    );
    
U1 : debouncer port map(
    in0 => in1(1),
    clk => clk,
    out0 => debounce_out(1)
    
    );
    
U2 : debouncer port map(
    in0 => in1(2),
    clk => clk,
    out0 => debounce_out(2)
    
    );
U3 : debouncer port map(
    in0 => in1(3),
    clk => clk,
    out0 => debounce_out(3)
    
    );
    
U4 : my_alu port map(
    A => A_internal,
    B => B_internal,
    OPCODE => OPCODE_internal,
    clk => clk,
    output =>output
);
end alu_tester_arch;

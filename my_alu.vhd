----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2024 07:32:54 PM
-- Design Name: 
-- Module Name: my_alu - Behavioral
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
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity my_alu is
    Port ( A, B : in STD_LOGIC_VECTOR (15 downto 0);
         OPCODE : in STD_LOGIC_VECTOR (3 downto 0);
         clk : in std_logic;
         aluOut : out STD_LOGIC_VECTOR (15 downto 0));
end my_alu;

architecture my_alu_arch of my_alu is
    signal SignedAgreaterThanB : std_logic;
    signal unsignedAgreaterThanB : std_logic;
    signal AequalB : std_logic;
    signal SignedAlessThanB : std_logic;
    signal unsignedALessThanB : std_logic;
    signal arithmeticShift : std_logic_vector(15 downto 0);
    signal zeros : std_logic_vector(15 downto 0) := (others => '0');

begin


    alu_change : process(clk)
    begin
    if(rising_edge(clk)) then


        if(signed(A) > signed(B)) then
            SignedAgreaterThanB <= '1';
            SignedAlessThanB <= '0';
        else
            SignedAgreaterThanB <= '0';
            SignedAlessThanB <= '1';
        end if;

        if(unsigned(A) > unsigned(B)) then
            unSignedAgreaterThanB <= '1';
            unSignedAlessThanB <= '0';
        else
            unSignedAgreaterThanB <= '0';
            unSignedAlessThanB <= '1';
        end if;
        
        if(A = B) then
            AequalB <= '0';
        else
            AequalB <= '1';
        end if;

            arithmeticShift <= std_logic_vector(shift_right(unsigned(a), 1));
            arithmeticShift(3) <= A(3);

            case OPCODE is
                when "0000" => aluOut <= A+B;
                when "0001" => aluOut <= A-B;
                when "0010" => aluOut <= A+1;
                when "0011" => aluOut <= A-1;
                when "0100" => aluOut <= 0-A;
                when "0101" => aluOut <= A(14 downto 0) & '0';
                when "0110" => aluOut <= '0' & A(15 downto 1);
                when "0111" => aluOut <= arithmeticShift;
                when "1000" => aluOut <= A and B;
                when "1001" => aluOut <= A or B;
                when "1010" => aluOut <= A xor B;
                when "1011" => aluOut <= std_logic_vector(zeros(15 downto 1) & SignedAlessThanB);
                when "1100" => aluOut <= std_logic_vector(zeros(15 downto 1) & SignedAgreaterThanB);
                when "1101" => aluOut <= std_logic_vector(zeros(15 downto 1) & AequalB);
                when "1110" => aluOut <= std_logic_vector(zeros(15 downto 1) & unsignedALessThanB);
                when "1111" => aluOut <= std_logic_vector(zeros(15 downto 1) & unsignedAgreaterThanB);
                when others => aluOut <= zeros;
            end case;
        end if;
    end process;

end my_alu_arch;


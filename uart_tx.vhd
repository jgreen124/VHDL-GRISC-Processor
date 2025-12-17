----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2024 01:57:05 AM
-- Design Name: 
-- Module Name: uart_tx - uart_tx_ar
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

entity uart_tx is
  Port (
    clk, en, send, rst : in std_logic;
    char : in std_logic_vector(7 downto 0);
    ready, tx : out std_logic
   );
end uart_tx;

architecture uart_tx_ar of uart_tx is
--rst high means state is idle and register is cleared
--when in idle state, ready is 1
--when send is asserted high and enable is 1 and the clock is on rising edge, 
--char is stored into register and state flips to start

--initialize states
type state is (idle, start, data);
signal PS : state := idle; --start in idle state

--register for char, loaded when send and enable are high and on rising clock
signal charReg : std_logic_vector(7 downto 0) := (others => '0');

--counter for data state
signal counter : std_logic_vector(2 downto 0) := (others => '0');

begin


--FSM process
FSM_proc : process(clk) begin

--reset state machine when reset is asserted
if(rising_edge(clk)) then
if rst = '1' then
    PS <= idle;
    charReg <= (others => '0');
    tx <= '1';
    ready <= '1';

--check if enable is high
elsif en = '1' then
    
    case PS is 
        when idle =>
            if(send = '1') then --condition to go from idle to start
                charReg <= char;
                PS <= start;
            else
                tx <= '1';
                PS <= idle;
                ready <= '1';
            end if;
        when start => --will send start bit and shift to data
            tx <= '0'; --start bit
            ready <= '0';
            PS <= data;
        when data =>
            if(unsigned(counter) < 7) then
                tx <= charReg(to_integer(unsigned(counter))); --transmit the current bit
                counter <= std_logic_vector(unsigned(counter) + 1);
            elsif(unsigned(counter) = 7) then
                tx <= charReg(to_integer(unsigned(counter)));
                PS <= idle;
                ready <= '1';
                counter <= (others => '0');
            end if;
        end case;
            
    
end if;
    
end if;

end process FSM_proc;



end uart_tx_ar;

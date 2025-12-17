----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2024 10:29:58 PM
-- Design Name: 
-- Module Name: controls - Behavioral
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

entity controls is
    Port (

        --timing signals
        clk, en, rst : in STD_LOGIC := '0';

        --register file IO
        rID1, rID2 : out std_logic_vector(4 downto 0) := (others => '1');
        wr_enR1, wr_enR2 : out std_logic := '0'; --control signals
        regrD1, regrD2 : in std_logic_vector(15 downto 0);
        regwD1, regwD2 : out std_logic_vector(15 downto 0);

        --frame buffer IO
        fbRST : out std_logic := '0';
        fbAddr1 : out std_logic_vector(11 downto 0):= (others => '0');
        fbDin1 : in std_logic_vector(15 downto 0):= (others => '0');
        fbDout1 : out std_logic_vector(15 downto 0):= (others => '0');
        fbWr_en : out std_logic := '0'; --control signal

        --Instruction Memory IO
        irAddr : out std_logic_vector(13 downto 0):= (others => '0');
        irWord : in std_logic_vector(31 downto 0):= (others => '0');


        --Data memory IO
        dAddr : out std_logic_vector(14 downto 0):= (others => '0');
        d_wr_en : out std_logic := '0';
        dOut : out std_logic_vector(15 downto 0):= (others => '0');
        dIn : in std_logic_vector(15 downto 0):= (others => '0');

        --ALU IO
        aluA, aluB : out std_logic_vector(15 downto 0):= (others => '0');
        aluOp : out std_logic_vector(3 downto 0):= (others => '0');
        aluResult : in std_logic_vector(15 downto 0):= (others => '0');

        --UART IO
        ready, newChar : in std_logic := '0';
        send : out std_logic := '0';
        charRec : in std_logic_vector(7 downto 0):= (others => '0');
        charSend : out std_logic_vector(7 downto 0):= (others => '0')

    );


end controls;

architecture Behavioral of controls is

    type state_type is (fetch1, fetch2, fetch3,  decode1, decode2, decode3, Rops1, Rops2, Iops1, Iops2, Jops, jmp, jal, clrscr, sw, equals1, equals2, nequal, ori, lw1, lw2, sendState1, sendState2, wpix1, wpix2, rpix, recv, jr, calc1, calc2, calc3, store, finish, finish2, finish3);
    signal presentState : state_type := fetch1;
    signal pc : std_logic_vector(15 downto 0) := (others => '1');
    signal irMem : std_logic_vector(31 downto 0);
    signal op : std_logic_vector(4 downto 0);
    signal reg1, reg2, reg3 : std_logic_vector(4 downto 0);
    signal imm : std_logic_vector(15 downto 0);
    signal aluAnswer : std_logic_vector(15 downto 0);
begin


    process(clk) begin

        if(rising_edge(clk)) then
            if(en = '1') then
                case presentState is
                    when fetch1 =>
                        rID1 <= "00001";
                        presentState <= fetch2;
                    when fetch2 =>
                        pc <= regrD1;
                        presentState <= fetch3;
                    --presentState <= decode1;
                    when fetch3 =>
                        presentState <= decode1;

                    when decode1 =>
                        irAddr <= pc(13 downto 0); --grab instruction using pc
                        regwD1 <= std_logic_vector(unsigned(pc) + 1);
                        wr_enR1 <= '1';
                        presentState <= decode2;
                    when decode2 =>
                        irMem <= irWord;
                        wr_enR1 <= '0'; --write enable to write back to reg 1
                        presentState <= decode3;
                    when decode3 =>
                        if(irMem(31 downto 30) = "00" or irMem(31 downto 30) = "01") then
                            presentState <= Rops1;
                        elsif(irMem(31 downto 30) = "10") then
                            presentState <= Iops1;
                        else
                            presentState <= Jops;
                        end if;



                    when Rops1 => --reg1, reg2, reg3
                        op <= irMem(31 downto 27);
                        reg1 <= irMem(26 downto 22);
                        reg2 <= irMem(21 downto 17);
                        reg3 <= irMem(16 downto 12);
                        rID1 <= reg2;
                        rID2 <= reg3;
                        presentState <= Rops2;
                    when Rops2 =>
                        if(op = "01101") then
                            presentState <= jr;
                        elsif(op = "01100") then
                            presentState <= recv;
                        elsif(op = "01111") then
                            presentState <= rpix;
                        elsif(op = "01110") then
                            presentState <= wpix1;
                        elsif(op = "01011") then
                            presentState <= sendState1;
                        else
                            presentState <= calc1;
                        end if;

                    when Iops1 => --op, reg1, reg2, imm
                        op <= irMem(31 downto 27);
                        reg1 <= irMem(26 downto 22);
                        reg2 <= irMem(21 downto 17);
                        rID1 <= reg1;
                        rID2 <= reg2;
                        imm <= irMem(16 downto 1);
                        presentState <= Iops2;
                    when Iops2 =>
                        if(op(2 downto 0) = "000") then
                            presentState <= equals1;
                        elsif(op(2 downto 0) = "001") then
                            presentState <= nequal;
                        elsif(op(2 downto 0) = "010") then
                            presentState <= ori;
                        elsif(op(2 downto 0) = "011") then
                            presentState <= lw1;
                        else
                            presentState <= sw;
                        end if;

                    when Jops => --op, imm
                        op <= irMem(31 downto 27);
                        reg1 <= irMem(26 downto 22);
                        imm <= irMem(26 downto 11);
                        if(op = "11000") then
                            presentState <= jmp;
                        elsif(op = "11001") then
                            presentState <= jal;
                        else
                            presentState <= clrscr;
                        end if;

                    when calc1 =>
                        aluA <= regrD1;
                        aluB <= regrD2;
                        aluOP <= op(4 downto 1);
                        presentState <= calc2;
                    when calc2 =>
                        presentState <= calc3;
                    when calc3 =>
                        aluAnswer <= aluResult;
                        presentState <= store;

                    when store =>
                        rID1 <= reg1;
                        regwD1 <= aluAnswer;
                        wr_enR1 <= '1';
                        presentState <= finish;

                    when jr =>
                        --not necessary for this lab
                    when recv =>
                        aluAnswer <= "00000000" & charRec;

                        if(newChar = '0') then
                            presentState <= recv;
                        else
                            presentState <= store;
                        end if;
                    when rpix =>
                        -- not necessary for this lab
                    when wpix1 =>
                        rID1 <= reg1;
                        rID2 <= reg2;
                        presentState <= wpix2;
                    when wpix2 =>
                        fbAddr1 <= regrD1(11 downto 0);
                        fbDout1 <= regrD2;
                        presentState <= finish;

                    when sendState1 =>
                        send <= '1';
                        rID1 <= reg1;
                        charSend <= regrD1( 7 downto 0);
                        presentState <= sendState2;

                    when sendState2 =>
                        if(ready = '1') then
                            send <= '0';
                            presentState <= finish;
                        else
                            presentState <= sendState2;
                        end if;

                    when equals1 =>
                        aluA <= regrD1;
                        aluB <= regrD2;
                        aluOp <= "1101";
                        aluAnswer <= aluResult;
                        presentState <= equals2;
                    --                  don't think equals2 is necessary  
                    when equals2 =>
                        if(aluAnswer = "0000000000000000") then
                            aluAnswer <= imm;
                            reg1 <= "00001";
                        else
                        --no else conditions
                    end if;
                        presentState <= store;


                    when nequal =>
                        --not necessary for this lab
                    when ori =>
                        aluAnswer <= regrD2 or imm;
                        presentState <= store;

                    when lw1 =>
                        --aluOp <= "0000";
                        dAddr <= std_logic_vector((unsigned(reg2(14 downto 0)) + unsigned(imm(14 downto 0))));
                        aluAnswer <= dIn;
                        presentState <= store;
                    when lw2 =>
                        aluAnswer <= dIn;
                        presentState <= store;

                    when sw =>
                        --not necessary for this lab

                    when jmp =>
                        rID1 <= "00001";
                        wr_enR1 <= '1';
                        regwD1 <= imm;
                        presentState <= finish;


                    when jal =>

                    when clrscr =>


                    when finish =>
                        wr_enR1 <= '0';
                        wr_enR2  <= '0';
                        d_wr_en <= '0';
                        fbRST <= '0';
                        send <= '0';
                        
                        pc <= regrD1;
                        presentState <= finish2;

                    when finish2 =>
                        rID1 <= "00001";
                        presentState <= finish3;
                    when finish3 =>
                        presentState <= fetch1;

                end case;

            end if;
        end if;
    end process;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: JEV TEAM
-- Engineer: Jindra Zobac
-- 
-- Create Date: 04/29/2024 10:40:42 AM
-- Design Name: Keyad module
-- Module Name: keypad - Behavioral
-- Project Name: Ciphers on FPGA
-- Target Devices: Nexys A50T
-- Tool Versions: 
-- Description: Purpose of this module is to scan 4x4 keyboard matrix
    -- and convert the registered keypresses to 5 bit vector representing
    -- respective letter. Because we need to be able to input 26 characters
    -- using this 16-key keypad, 2 letters belong to each key. This module 
    -- only outputs the first letters, double-presses are handled in the 
    -- "interpreter" module.
-- 
-- Dependencies: keypad.vhd
-- 
-- Revision: 1
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity keyboard_matrix is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           ROW : out STD_LOGIC_VECTOR (3 downto 0);   -- in constraints assign rows R0, R1, R2, R3 (top to bottom)
           COL : in STD_LOGIC_VECTOR (3 downto 0);    -- in constraints assign columns C1, C2, C3, C4 (left to right)
           KEY : out STD_LOGIC_VECTOR (4 downto 0));  -- 5bit code of the letter (00001 = A, 00010 = B etc)
end keyboard_matrix;

architecture Behavioral of keyboard_matrix is

    type state_type is (S1, S2, S3, S4);  -- States of FSM 
    signal current_state: state_type;  -- signals for current and next state
    signal next_state: state_type :=S1;
    signal row_value : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal col_value: STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal letter_out: STD_LOGIC_VECTOR (4 downto 0) := "00000";


begin


    
process(CLK, RST)
begin
    
    if RST = '1' then
            current_state <= S1;
            next_state <= S1;
            row_value <= "0000";
            col_value <="0000";      
        elsif rising_edge(CLK) then
            current_state <= next_state;
            col_value <=COL;
            ROW <= row_value;
            KEY <= letter_out;
        -- FSM: cycles trough states 1, 2, 3, 4 and in each state pulls one row to logic zero. Also saves the state of
        -- rows into row-value variable to be able to read it later.
        case current_state is
            when S1 =>
                next_state <= S2;  -- Transition from S1 to S2
                row_value <= "1110";
            when S2 =>
                next_state <= S3;  -- Transition from S2 to S3
                row_value <= "1101";
            when S3 =>
                next_state <= S4;  -- Transition from S3 to S4
                row_value <= "1011";                
            when S4 =>
                next_state <= S1;  -- Transition from S4 to S1
                row_value <= "0111";
            when others =>
                row_value <= "1111";
        end case;
   end if;

end process;

    -- Column scan: Each clock cycle is one row active and all columns are scanned. Logic zero detected on any of the
    -- column pins means a key in the current row and column is pressed and respective key code is saved into letter_out
    -- and later mirrored into KEY output. Last twwo keys have special functions SEND and BACKSPACE that are processed in
    -- "interpreter" module
    process(CLK)
        begin      
        if rising_edge(CLK) then
            case row_value is
                when "0111" => 
                    case col_value is
                        when "0111" => letter_out <= "00001"; --A (B)
                        when "1011" => letter_out <= "00011"; --C (D)
                        when "1101" => letter_out <= "00101"; --E (F)
                        when "1110" => letter_out <= "00111"; --G (H)
                        when others => null;
                    end case;
                when "1011" => 
                    case col_value is
                        when "0111" => letter_out <= "01001"; --I (J)
                        when "1011" => letter_out <= "01011"; --K (L)
                        when "1101" => letter_out <= "01101"; --M (N)
                        when "1110" => letter_out <= "01111"; --O (P)
                        when others => null;
                    end case;
                when "1101" => 
                    case col_value is
                        when "0111" => letter_out <= "10001"; --Q
                        when "1011" => letter_out <= "10011"; --S
                        when "1101" => letter_out <= "10101"; --U
                        when "1110" => letter_out <= "10111"; --W
                        when others => null;
                    end case;
                when "1110" => 
                    case col_value is
                        when "0111" => letter_out <= "11001"; --Y
                        when "1110" => letter_out <= "11111"; --SEND
                        when "1101" => letter_out <= "11110"; --BACKSPACE
                        
                        when others => null;
                    end case;
                when others => null;
            end case;
        end if;
    end process;
    

end Behavioral;

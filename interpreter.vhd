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
-- Description: Purpose of this module is to generate a short pulse containing a letter code upon every hit of "SEND" key.
    -- it also triggers BACKSPACE pulse upon press of BACKSPACE key. The resulting letter code is based on last 2 pressed
    -- keys. If double press is detected, the incoming letter code is incremented (= next letter)
-- 
-- Dependencies:
-- 
-- Revision: 1
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity interpreter is
    port (
        CLK : in STD_LOGIC;
        KEY: in std_logic_vector(4 downto 0);
        LETTER_OUT: out std_logic_vector(4 downto 0) := "00000";
        BCKSPC: out std_logic := '0'
    );
end entity interpreter;

architecture Behavioral of interpreter is
    type state_type is (IDLE, NEWKEY, DOUBLEKEY,OUTPUT, BACKSPACE);
    signal state: state_type;
    signal curr_key: std_logic_vector(4 downto 0):= "00000";
   
    
    signal pulse_active : std_logic := '0';

begin
    process (CLK)
    variable letter: unsigned(4 downto 0) := "00000";
    variable prev_key: unsigned(4 downto 0):= "00000";
    begin
    
    if rising_edge(CLK) then
    curr_key <= KEY;
    --FSM has 5 states:
        -- IDLE: waiting for a keypress. First checks if any special key has been pressed and then checks the other keys
        -- if "ordinary" key is pressed, algorithm decides the next state NEWKEY or DOUBLEKEY by comparing previous
        -- input key with current.
        case state is
            when IDLE =>
                if KEY /= "00000" then
                    if KEY = "11110" then
                            pulse_active <= '1';
                            state <= BACKSPACE;
                    elsif KEY =  "11111" then
                            pulse_active <= '1';
                            
                            state <= OUTPUT;
                    elsif KEY =  std_logic_vector(prev_key) then
                            state <= DOUBLEKEY;
                    else
                            state <= NEWKEY;
                    end if;
                end if;
            
            when NEWKEY =>
                letter := unsigned(curr_key);
                prev_key := unsigned(curr_key);
                if KEY = "00000" then
                    state <= IDLE;
                end if;

            when DOUBLEKEY =>
                letter:= unsigned(curr_key) + 1;
                prev_key := "00000";
                if KEY = "00000" then
                    state <= IDLE;
                end if;
                
            when OUTPUT =>
                if pulse_active = '1' then
                    LETTER_OUT <= std_logic_vector(letter);
                    prev_key := "00000";
                    letter:= "00000";
                    pulse_active <= '0'; -- Deactivate pulse for next cycle
                elsif KEY = "00000" then
                    LETTER_OUT <= "00000";
                    state <= IDLE;

                else
                    LETTER_OUT <= "00000";
                end if;
                

            when BACKSPACE =>
                if pulse_active = '1' then
                    BCKSPC <= '1';
                    pulse_active <= '0'; -- Deactivate pulse for next cycle
                elsif KEY = "00000" then
                    LETTER_OUT <= "00000";
                    BCKSPC <= '0';
                    state <= IDLE;
                else
                    -- If pulse is inactive, set output to '0000'
                    LETTER_OUT <= "00000";
                    BCKSPC <= '0';
                end if;
                
                
                
            when others =>
                null;
        end case;
    end if;
    end process;
end architecture Behavioral;

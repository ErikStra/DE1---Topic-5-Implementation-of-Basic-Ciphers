----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2024 10:43:12 AM
-- Design Name: 
-- Module Name: interpreter - Behavioral
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
                --letter := "00110";
                letter := unsigned(curr_key);
                --letter:= unsigned(KEY);
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
                    -- If pulse is active, set bus_signal to 
                    LETTER_OUT <= std_logic_vector(letter);
                    prev_key := "00000";
                    letter:= "00000";
                    pulse_active <= '0'; -- Deactivate pulse for next cycle
                elsif KEY = "00000" then
                    LETTER_OUT <= "00000";
                    state <= IDLE;

                else
                    -- If pulse is inactive, set bus_signal to '0000'
                    LETTER_OUT <= "00000";
                end if;
                

            when BACKSPACE =>
                if pulse_active = '1' then
                    -- If pulse is active, set bus_signal to 
                    BCKSPC <= '1';
                    pulse_active <= '0'; -- Deactivate pulse for next cycle
                elsif KEY = "00000" then
                    LETTER_OUT <= "00000";
                    BCKSPC <= '0';
                    state <= IDLE;
                else
                    -- If pulse is inactive, set bus_signal to '0000'
                    LETTER_OUT <= "00000";
                    BCKSPC <= '0';
                end if;
                
                
                
            when others =>
                null;
        end case;
    end if;
    end process;
end architecture Behavioral;

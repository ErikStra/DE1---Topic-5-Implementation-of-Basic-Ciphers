----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2024 09:32:48 AM
-- Design Name: 
-- Module Name: keypad - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity keypad_interface is
    Port (
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        ROW0, ROW1, ROW2, ROW3 : out STD_LOGIC;
        COL0, COL1, COL2, COL3 : in STD_LOGIC;
        KEY_OUT : out STD_LOGIC_VECTOR (4 downto 0)
    );
end keypad_interface;

architecture Behavioral of keypad_interface is
    signal current_state, next_state : integer range 0 to 15 := 0;
    signal row_value : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal pressed_keys : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal key_count : STD_LOGIC := '0';
    signal current_key : integer range 0 to 16 := 0;
    signal delay_counter : integer range 0 to 10 := 0;  -- Change 10 to desired delay
begin

    process(CLK, RESET)
    begin
        if RESET = '1' then
            current_state <= 0;
            row_value <= "0000";
            pressed_keys <= (others => '0');
            key_count <= '0';
            current_key <= 0;
        elsif rising_edge(CLK) then
            current_state <= next_state;
            case current_state is
                when 0 =>
                    row_value <= "1110";  -- Enable ROW0, disable ROW1, ROW2, ROW3
                when 1 =>
                    row_value <= "1101";  -- Enable ROW1, disable ROW0, ROW2, ROW3
                when 2 =>
                    row_value <= "1011";  -- Enable ROW2, disable ROW0, ROW1, ROW3
                when 3 =>
                    row_value <= "0111";  -- Enable ROW3, disable ROW0, ROW1, ROW2
                when others =>
                    row_value <= "0000";  -- Disable all rows
            end case;
        end if;
    end process;

    process(CLK)
    begin
        if rising_edge(CLK) then
            case row_value is
                when "1110" =>
                    if COL0 = '0' then
                        if current_key = 1 then
                            key_count <= '1';
                        else
                            current_key <= 1;
                            key_count <= '0';
                        end if;
                        
                    elsif COL1 = '0' then
                        if current_key = 2 then
                            key_count <= key_count + 1;
                        else
                            current_key <= 2;
                            key_count <= 1;
                        end if;
                        
                   elsif COL2 = '0' then
                        if current_key = 3 then
                            key_count <= key_count + 1;
                        else
                            current_key <= 3;
                            key_count <= 1;
                        end if;
                   elsif COL3 = '0' then
                        if current_key = 4 then
                            key_count <= key_count + 1;
                        else
                            current_key <= 4;
                            key_count <= 1;
                        end if;
                  
                    -- similarly for other keys
                    end if;
                    
                    
               when "1101" =>
                    if COL0 = '0' then
                        if current_key = 5 then
                            key_count <= key_count + 1;
                        else
                            current_key <= 5;
                            key_count <= 1;
                        end if;
                        
                    elsif COL1 = '0' then
                        if current_key = 6 then
                            key_count <= key_count + 1;
                        else
                            current_key <= 6;
                            key_count <= 1;
                        end if;
                        
                   elsif COL2 = '0' then
                        if current_key = 7 then
                            key_count <= key_count + 1;
                        else
                            current_key <= 7;
                            key_count <= 1;
                        end if;
                   elsif COL3 = '0' then
                        if current_key = 8 then
                            key_count <= key_count + 1;
                        else
                            current_key <= 8;
                            key_count <= 1;
                        end if;
                    -- similarly for other keys
                    end if;
                    
                    
               when "1011" =>
                    if COL0 = '0' then
                        if current_key = 9 then
                            key_count <= key_count + 1;
                        else
                            current_key <= 9;
                            key_count <= 1;
                        end if;
                        
                    elsif COL1 = '0' then
                        if current_key = 10 then
                            key_count <= key_count + 1;
                        else
                            current_key <= 10;
                            key_count <= 1;
                        end if;
                        
                   elsif COL2 = '0' then
                        if current_key = 11 then
                            key_count <= key_count + 1;
                        else
                            current_key <= 11;
                            key_count <= 1;
                        end if;
                   elsif COL3 = '0' then
                        if current_key = 12 then
                            key_count <= key_count + 1;
                        else
                            current_key <= 12;
                            key_count <= 1;
                        end if;
                    -- similarly for other keys
                    end if;
                    
              when "0111" =>
                    if COL0 = '0' then
                        if current_key = 13 then
                            key_count <= key_count + 1;
                        else
                            current_key <=13;
                            key_count <= 1;
                        end if;
                        
                    elsif COL1 = '0' then
                        if current_key = 14 then
                            key_count <= key_count + 1;
                        else
                            current_key <= 14;
                            key_count <= 1;
                        end if;
                        
                   elsif COL2 = '0' then
                        if current_key = 15 then
                            key_count <= key_count + 1;
                        else
                            current_key <= 15;
                            key_count <= 1;
                        end if;
                   elsif COL3 = '0' then
                        if current_key = 16 then
                            key_count <= key_count + 1;
                        else
                            current_key <= 16;
                            key_count <= 1;
                        end if;
                    -- similarly for other keys
                    end if;
                    -- similarly for other rows
             when others => null;
            end case;
        end if;
    end process;

    process(CLK)
    begin
        if rising_edge(CLK) then
            if key_count = 1 then
                case current_key is
                    when 1 => pressed_keys <= "00000"; --'A';
                    when 2 => pressed_keys <= "00010"; --'C';
                    when 3 => pressed_keys <= "00100"; --'E';
                    when 4 => pressed_keys <= "00110"; --'G';

                    when 5 => pressed_keys <= "01000"; --'I';
                    when 6 => pressed_keys <= "01010";--'K';
                    when 7 => pressed_keys <= "01100";--'M';
                    when 8 => pressed_keys <= "01110"; --'O';

                    when 9 => pressed_keys <= "10000"; --'Q';
                    when 10 => pressed_keys <= "10010"; --'S';
                    when 11 => pressed_keys <= "10100"; --'U';
                    when 12 => pressed_keys <= "10110"; --'W';
                    when 13 => pressed_keys <= "11000"; --'Y';
                    -- similarly for other keys
                    when others => null;
                end case;
            elsif key_count = 2 then
                case current_key is
                    when 1 => pressed_keys <= "00001"; --'B';
                    when 2 => pressed_keys <= "00011"; --'D';
                    when 3 => pressed_keys <= "00101"; --'F';
                    when 4 => pressed_keys <= "00111"; --'H';

                    when 5 => pressed_keys <= "01001"; --'J';
                    when 6 => pressed_keys <= "01011";--'L';
                    when 7 => pressed_keys <= "01101";--'N';
                    when 8 => pressed_keys <= "01111"; --'P';

                    when 9 => pressed_keys <= "10001"; --'R';
                    when 10 => pressed_keys <= "10011"; --'T';
                    when 11 => pressed_keys <= "10101"; --'V';
                    when 12 => pressed_keys <= "10111"; --'X';
                    when 13 => pressed_keys <= "11001"; --'Z';
                    -- similarly for other keys
                    when others => null;
                end case;
            elsif key_count >2 then
                --key_count <= 0;
            end if;
            --key_count <= 0;
            current_key <= 0;
        end if;
    end process;
    
    process(CLK)
    begin
        if rising_edge(CLK) then
            if key_count > 0 then
                delay_counter <= 0;  -- Reset delay counter on any key press
                
            else delay_counter <= delay_counter + 1;
            end if;
            
            if delay_counter = 10 then
                KEY_OUT <= pressed_keys(4 downto 0);
                delay_counter <= 0;
                
            else
                KEY_OUT <= (others => '0');
            end if;
        end if;
    end process;


end Behavioral;


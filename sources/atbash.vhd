----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2024 09:32:17 AM
-- Design Name: 
-- Module Name: atbashcipher - Behavioral
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

entity atbashcipher is
    Port ( clk : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (4 downto 0);
           output : out STD_LOGIC_VECTOR (4 downto 0));
end atbashcipher;

architecture Behavioral of atbashcipher is

begin
    process (clk)
    begin
        if rising_edge(clk) then  
                case input(4 downto 0) is
                    when "00001" =>
                    output(4 downto 0) <= "11010";
                
                    when  "00010" =>
                    output(4 downto 0) <= "11001";
                    
                    when  "00011" =>
                    output(4 downto 0) <= "11000";
                    
                    when  "00100" =>
                    output(4 downto 0) <= "10111";
                    
                    when  "00101" =>
                    output(4 downto 0) <= "10110";
                    
                    when  "00110" =>
                    output(4 downto 0) <= "10101";
                    
                    when  "00111" =>
                    output(4 downto 0) <= "10100";
                    
                    when  "01000" =>
                    output(4 downto 0) <= "10011";
                    
                    when  "01001" =>
                    output(4 downto 0) <= "10010";
                    
                    when  "01010" =>
                    output(4 downto 0) <= "10001";
                    
                    when  "01011" =>
                    output(4 downto 0) <= "10000";
                    
                    when  "01100" =>
                    output(4 downto 0) <= "01111";
                    
                    when  "01101" =>
                    output(4 downto 0) <= "01110";
                    
                    when  "01110" =>
                    output(4 downto 0) <= "01101";
                    
                    when  "01111" =>
                    output(4 downto 0) <= "01100";
                    
                    when  "10000" =>
                    output(4 downto 0) <= "01011";
                    
                    when  "10001" =>
                    output(4 downto 0) <= "01010";
                    
                    when  "10010" =>
                    output(4 downto 0) <= "01001";
                    
                    when  "10011" =>
                    output(4 downto 0) <= "01000";
                    
                    when  "10100" =>
                    output(4 downto 0) <= "00111";
                    
                    when  "10101" =>
                    output(4 downto 0) <= "00110";
                    
                    when  "10110" =>
                    output(4 downto 0) <= "00101";
                    
                    when  "10111" =>
                    output(4 downto 0) <= "00100";
                    
                    when  "11000" =>
                    output(4 downto 0) <= "00011";
                    
                     when  "11001" =>
                    output(4 downto 0) <= "00010";
                    
                     when  "11010" =>
                    output(4 downto 0) <= "00001";
                    
                    when others =>
                    output(4 downto 0) <= "00000";
                    
                    end case;
                
         end if;
                        
    end process;
  end Behavioral;
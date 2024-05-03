----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2024 10:37:38 AM
-- Design Name: 
-- Module Name: cezar - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cezar is
    Port ( clk : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (4 downto 0);
           key : in STD_LOGIC_VECTOR (4 downto 0);
           coded_txt : in STD_LOGIC_VECTOR (4 downto 0);
           SW : in STD_LOGIC;
           code_out : out STD_LOGIC_VECTOR (4 downto 0);
           decode_out : out STD_LOGIC_VECTOR (4 downto 0));
end cezar;



architecture Behavioral of cezar is

begin
    code : process (clk)
    variable cezar_sum: unsigned(4 downto 0); 
    begin
        if rising_edge(clk) then                    
           if(SW='0') then
                cezar_sum:= unsigned(input) + unsigned(key);
                code_out <= std_logic_vector(cezar_sum);
            end if;
        end if;
    end process code;
    
    decode : process (clk)
    variable cezar_min : unsigned(4 downto 0);
    begin
        if rising_edge(clk) then
            if(SW='1') then
                cezar_min := unsigned(coded_txt) - unsigned(key);
                decode_out <= std_logic_vector(cezar_min);
            end if;
        end if;
    end process decode;
end Behavioral;

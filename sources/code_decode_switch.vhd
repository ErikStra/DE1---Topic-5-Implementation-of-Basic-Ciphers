----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jindra Zobač
-- 
-- Create Date: 05/02/2024 11:24:12 AM
-- Design Name: Sitch
-- Module Name: code_decode_switch - Behavioral
-- Project Name: Ciphers on FPGA
-- Target Devices: 
-- Tool Versions: 
-- Description: simple switch to choose between 2 input signals
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

entity code_decode_switch is
    Port ( clk : in STD_LOGIC;
           input_1 : in STD_LOGIC_VECTOR (4 downto 0);
           input_2 : in STD_LOGIC_VECTOR (4 downto 0);
           switch : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (4 downto 0));
end code_decode_switch;

architecture Behavioral of code_decode_switch is

begin

    process(CLK)
        begin      
        if rising_edge(CLK) then
            if switch = '0' then
                output <= input_1;
            else
                output <= input_2;
            end if;
        end if;
    end process;

end Behavioral;

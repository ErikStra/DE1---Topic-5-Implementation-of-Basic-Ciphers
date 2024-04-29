----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2024 10:40:42 AM
-- Design Name: 
-- Module Name: tb_keypad - Behavioral
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

-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 26.4.2024 08:10:18 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_keyboard_matrix is
end tb_keyboard_matrix;

architecture tb of tb_keyboard_matrix is

    component keyboard_matrix
        port (CLK : in std_logic;
              RST : in std_logic;
              ROW : out std_logic_vector (3 downto 0);
              COL : in std_logic_vector (3 downto 0);
              KEY : out std_logic_vector (4 downto 0));
    end component;

    signal CLK : std_logic;
    signal RST : std_logic;
    signal ROW : std_logic_vector (3 downto 0);
    signal COL : std_logic_vector (3 downto 0);
    signal KEY : std_logic_vector (4 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : keyboard_matrix
    port map (CLK => CLK,
              RST => RST,
              ROW => ROW,
              COL => COL,
              KEY => KEY);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        COL <= (others => '1');

        -- Reset generation
        -- EDIT: Check that RST is really your reset signal
        RST <= '1';
        wait for 100 ns;
        RST <= '0';
        wait for 100 ns;
        
        COL <= "1111";
        wait for 10 ns;
        COL <= "1111";
        wait for 2 * TbPeriod;
        COL <= "1110";
        wait for 3 * TbPeriod;
        COL <= "1101";
        wait for 2 * TbPeriod;
        COL <= "1011";
        wait for 1 * TbPeriod;
        COL <= "0111";
        wait for 2 * TbPeriod;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_keyboard_matrix of tb_keyboard_matrix is
    for tb
    end for;
end cfg_tb_keyboard_matrix;

----------------------------------------------------------------------------------
-- Company: JEV TEAM
-- Engineer: Jindra Zobac
-- 
-- Create Date: 04/29/2024 10:40:42 AM
-- Design Name: Interpreter
-- Module Name: keypad - Behavioral
-- Project Name: Ciphers on FPGA
-- Target Devices: Nexys A50T
-- Tool Versions: 
-- Description: Testbench for "interpreter" module
-- 
-- Dependencies: interpreter
-- 
-- Revision: 1
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 29.4.2024 08:58:44 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_interpreter is
end tb_interpreter;

architecture tb of tb_interpreter is

    component interpreter
        port (CLK        : in std_logic;
              KEY        : in std_logic_vector (4 downto 0);
              LETTER_OUT : out std_logic_vector (4 downto 0);
              BCKSPC     : out std_logic);
    end component;

    signal CLK        : std_logic;
    signal KEY        : std_logic_vector (4 downto 0);
    signal LETTER_OUT : std_logic_vector (4 downto 0);
    signal BCKSPC     : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : interpreter
    port map (CLK        => CLK,
              KEY        => KEY,
              LETTER_OUT => LETTER_OUT,
              BCKSPC     => BCKSPC);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        KEY <= (others => '0');
        wait for 10 * TbPeriod;
        KEY <= "00001";
        wait for 1 * TbPeriod;
        KEY <= "00000";
        wait for 1 * TbPeriod;
        KEY <= "00001";
        wait for 1 * TbPeriod;
        KEY <= "00000";
        wait for 3 * TbPeriod;
        KEY <= "11111";
        wait for 1 * TbPeriod;
        KEY <= "00000";
        
        wait for 5 * TbPeriod;
        KEY <= "11110";
        wait for 2 * TbPeriod;
        KEY <= "00000";
        
        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_interpreter of tb_interpreter is
    for tb
    end for;
end cfg_tb_interpreter;

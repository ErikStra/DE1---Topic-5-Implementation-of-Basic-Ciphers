----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2024 09:58:44
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level is
    Port ( CLK100MHZ : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (3 downto 0);
           SW1 : in STD_LOGIC;
           SW2 : in STD_LOGIC;
           R1 : out STD_LOGIC;
           R2 : out STD_LOGIC;
           R3 : out STD_LOGIC;
           R4 : out STD_LOGIC;
           C1 : in STD_LOGIC;
           C2 : in STD_LOGIC;
           C3 : in STD_LOGIC;
           C4 : in STD_LOGIC);
end top_level;

architecture Behavioral of top_level is

signal RESET: STD_LOGIC;
signal TMP_KEY: std_logic_vector(4 downto 0);
signal TMP_LETTER: std_logic_vector(4 downto 0);
signal TMP_INPUT: std_logic_vector(4 downto 0);
signal TMP_PROCESSED: std_logic_vector(4 downto 0);
signal TMP_OUTPUT: std_logic_vector(4 downto 0);




component keypad is
    port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           ROW : out STD_LOGIC_VECTOR (3 downto 0);   -- in constraints assign rows R0, R1, R2, R3 (top to bottom)
           COL : in STD_LOGIC_VECTOR (3 downto 0);    -- in constraints assign columns C1, C2, C3, C4 (left to right)
           KEY : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component interpreter is
    port ( CLK : in STD_LOGIC;
           KEY: in std_logic_vector(4 downto 0);
           LETTER_OUT: out std_logic_vector(4 downto 0);
           BCKSPC: out std_logic);
end component;

component Vernam is
     port ( clk             : in std_logic;
            input           : in  std_logic_vector(4 downto 0);
            key           	: in  std_logic_vector(4 downto 0);
            coded_txt       : in STD_LOGIC_VECTOR(4 downto 0);
            SW              : in STD_LOGIC;
            code_out     : out std_logic_vector(4 downto 0);
            decode_out   : out std_logic_vector(4 downto 0));
end component;

component atbashcipher is
    Port ( clk : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (4 downto 0);
           output : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component cezar is
    port ( clk : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (4 downto 0);
           key : in STD_LOGIC_VECTOR (4 downto 0);
           coded_txt : in STD_LOGIC_VECTOR (4 downto 0);
           SW : in STD_LOGIC;
           code_out : out STD_LOGIC_VECTOR (4 downto 0);
           decode_out : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component seven_segment_display_VHDL is 
    port ( 
           reset : in STD_LOGIC; -- reset
           LED_BCD : in STD_LOGIC_VECTOR (4 downto 0);
           Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
           Seven_Segment : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component code_decode_switch is
    port ( clk : in STD_LOGIC;
           input_1 : in STD_LOGIC_VECTOR (4 downto 0);
           input_2 : in STD_LOGIC_VECTOR (4 downto 0);
           switch : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (4 downto 0));
end component;

begin

    display : seven_segment_display_VHDL
        port map (
          
          reset  => RESET,
          LED_BCD => TMP_OUTPUT,
          Seven_Segment(0) =>  CA,
          Seven_Segment(1) =>  CB,
          Seven_Segment(2) =>  CC,
          Seven_Segment(3) =>  CD,
          Seven_Segment(4) =>  CE,
          Seven_Segment(5) =>  CF,
          Seven_Segment(6) =>  CG,
          Anode_Activate(0) => AN(0),   -- only one anode is used so far
          Anode_Activate(1) => AN(1),
          Anode_Activate(2) => AN(2),
          Anode_Activate(3) => AN(3));
    
    keyboard : keypad
        port map(
            CLK => CLK100MHZ,
            RST => RESET,
            ROW(3) => R1,
            ROW(2) => R2,
            ROW(1) => R3,
            ROW(0) => R4,
            
            COL(3) => C1,
            COL(2) => C2,
            COL(1) => C3,
            COL(0) => C4,
            
            KEY => TMP_KEY);
     
     interpret : interpreter
        port map(
           CLK => CLK100MHZ,
           KEY => TMP_KEY,
           LETTER_OUT => TMP_LETTER,
           BCKSPC => RESET);
            
            
     cipher1 : atbashcipher
        port map(
           clk => CLK100MHZ,
           input => TMP_LETTER,
           output => TMP_PROCESSED);
            
    codeswitch : code_decode_switch -- despite its name is used for switcing between input and output to be displayed
        port map(
            clk => CLK100MHZ,
            input_1 => TMP_LETTER,
            input_2 => TMP_PROCESSED,
            switch =>SW2,
            output => TMP_OUTPUT);
            
    
     
    

end Behavioral;

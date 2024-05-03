library ieee;
  use ieee.std_logic_1164.all;

-------------------------------------------------

entity seven_segment_display_VHDL is
  port (
    reset : in    std_logic;                    --! reset the display
    LED_BCD   : in    std_logic_vector(4 downto 0); --! Binary representation of one hexadecimal symbol
    Seven_Segment   : out   std_logic_vector(6 downto 0);  --! Seven active-low segments from A to G
    Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0)-- 4 Anode signals 
  );
end entity seven_segment_display_VHDL;

-------------------------------------------------

architecture behavioral of seven_segment_display_VHDL is
begin
    Anode_Activate <= "0111";

  --! This combinational process decodes binary
  --! input (`LED_BCD`) into 7-segment display output
  --! (`seg`) for a Common Anode configuration.
  --! When either `LED_BCD` or `reset` changes, the
  --! process is triggered. Each bit in `seg`
  --! represents a segment from A to G. The display
  --! is reseted if input `reset` is set to 1.
  p_7seg_decoder : process (LED_BCD, reset) is
  begin

    if (reset = '1') then
       Seven_Segment <= "1111111";     -- reset the display
    else
      case LED_BCD is
    when "00000" =>
         Seven_Segment <= "0111111"; -- (-)
    when "00001" =>
         Seven_Segment <= "1011111"; -- A
    when "00010" =>
         Seven_Segment <= "1111100"; -- B
    when "00011" =>
         Seven_Segment <= "1011000"; -- C
    when "00100" =>
         Seven_Segment <= "1011110"; -- D
    when "00101" =>
         Seven_Segment <= "1111001"; -- E
    when "00110" =>
         Seven_Segment <= "1110001"; -- F
    when "00111" =>
         Seven_Segment <= "0111110"; -- G
    when "01000" =>
         Seven_Segment <= "1110100"; -- H
    when "01001" =>
         Seven_Segment <= "0010001"; -- I
    when "01010" =>
         Seven_Segment <= "0001101"; -- J
    when "01011" =>
         Seven_Segment <= "1110101"; -- K
    when "01100" =>
         Seven_Segment <= "0111000"; -- L
    when "01101" =>
         Seven_Segment <= "1010101"; -- M
    when "01110" =>
         Seven_Segment <= "1010100"; -- N
    when "01111" =>
         Seven_Segment <= "1011100"; -- O
    when "10000" =>
         Seven_Segment <= "1110011"; -- P
    when "10001" =>
         Seven_Segment <= "1100111"; -- Q
    when "10010" =>
         Seven_Segment <= "1010000"; -- R
    when "10011" =>
         Seven_Segment <= "0101101"; -- S
    when "10100" =>
         Seven_Segment <= "1111000"; -- T
    when "10101" =>
         Seven_Segment <= "0011100"; -- U
    when "10110" =>
         Seven_Segment <= "0101010"; -- V
    when "10111" =>
         Seven_Segment <= "1101010"; -- W
    when "11000" =>
         Seven_Segment <= "0010100"; -- X
    when "11001" =>
         Seven_Segment <= "1101110"; -- Y
    when "11010" =>
         Seven_Segment <= "0011011"; -- Z
    when others =>
         Seven_Segment <= "1111111"; -- null
end case;

    end if;

  end process p_7seg_decoder;

end architecture behavioral;
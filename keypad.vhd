library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity keyboard_matrix is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           ROW : out STD_LOGIC_VECTOR (3 downto 0);
           COL : in STD_LOGIC_VECTOR (3 downto 0);
           KEY : out STD_LOGIC_VECTOR (4 downto 0));
end keyboard_matrix;

architecture Behavioral of keyboard_matrix is

    type state_type is (S1, S2, S3, S4);  -- Define the states
    signal current_state: state_type;  -- Define signals for current and next state
    signal next_state: state_type :=S1;
    signal row_value : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal col_value: STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal letter_out: STD_LOGIC_VECTOR (4 downto 0) := "00000";


begin


    
process(CLK, RST)
begin
    
    if RST = '1' then
            current_state <= S1;
            next_state <= S1;
            row_value <= "0000";
            col_value <="0000";      
        elsif rising_edge(CLK) then
            current_state <= next_state;
            col_value <=COL;
            ROW <= row_value;
            KEY <= letter_out;
    
        case current_state is
            when S1 =>
                next_state <= S2;  -- Transition from S1 to S2
                row_value <= "1110";
            when S2 =>
                next_state <= S3;  -- Transition from S2 to S3
                row_value <= "1101";
            when S3 =>
                next_state <= S4;  -- Transition from S3 to S4
                row_value <= "1011";                
            when S4 =>
                next_state <= S1;  -- Transition from S4 to S1
                row_value <= "0111";
            when others =>
                row_value <= "1111";
        end case;
   end if;

end process;

    process(CLK)
        begin      
        if rising_edge(CLK) then
            case row_value is
                when "1110" => 
                    case col_value is
                        when "0111" => letter_out <= "00001"; --A
                        when "1011" => letter_out <= "00011"; --C
                        when "1101" => letter_out <= "00101"; --E
                        when "1110" => letter_out <= "00111"; --G
                        when others => null;
                    end case;
                when "1101" => 
                    case col_value is
                        when "0111" => letter_out <= "01001"; --I
                        when "1011" => letter_out <= "01011"; --K
                        when "1101" => letter_out <= "01101"; --M
                        when "1110" => letter_out <= "01111"; --O
                        when others => null;
                    end case;
                when "1011" => 
                    case col_value is
                        when "0111" => letter_out <= "10001"; --Q
                        when "1011" => letter_out <= "10011"; --S
                        when "1101" => letter_out <= "10101"; --U
                        when "1110" => letter_out <= "10111"; --W
                        when others => null;
                    end case;
                when "0111" => 
                    case col_value is
                        when "0111" => letter_out <= "11001"; --Y
                        when "1110" => letter_out <= "11111"; --SEND
                        when "1101" => letter_out <= "11110"; --BACKSPACE
                        
                        when others => null;
                    end case;
                when others => null;
            end case;
        end if;
    end process;
    

end Behavioral;

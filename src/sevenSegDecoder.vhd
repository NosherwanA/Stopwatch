library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sevenSegDecoder is
    port(
        in_1            : in std_logic_vector(7 downto 0);
        in_2            : in std_logic_vector(7 downto 0);
        in_3            : in std_logic_vector(7 downto 0);
        hex_0           : out std_logic_vector(6 downto 0); 
        hex_1           : out std_logic_vector(6 downto 0);
        hex_2           : out std_logic_vector(6 downto 0);
        hex_3           : out std_logic_vector(6 downto 0);
        hex_4           : out std_logic_vector(6 downto 0);
        hex_5           : out std_logic_vector(6 downto 0)
    );
end sevenSegDecoder;

architecture internal of sevenSegDecoder is
    
    signal min_1, min_0, sec_1, sec_0, frac_1, frac_0      : std_logic_vector(3 downto 0);
    
    begin

        min_1 <= in_1(7 downto 4);
        min_0 <= in_1(3 downto 0);
        sec_1 <= in_2(7 downto 4);
        sec_0 <= in_2(3 downto 0);
        frac_1 <= in_3(7 downto 4);
        frac_0 <= in_3(3 downto 0);

        -- Decoding
        process(min_1) 
            begin
                case min_1 is 
                    when "0000" =>
                        hex_5 <= "1000000";
                    when "0001" =>
                        hex_5 <= "1111001";
                    when "0010" =>
                        hex_5 <= "0100100";
                    when "0011" =>
                        hex_5 <= "0110000";
                    when "0100" =>
                        hex_5 <= "0011001";
                    when "0101" =>
                        hex_5 <= "0010010";
                    when "0110" =>
                        hex_5 <= "0000010";
                    when "0111" =>
                        hex_5 <= "1111000";
                    when "1000" =>
                        hex_5 <= "0000000";
                    when "1001" =>
                        hex_5 <= "0011000";
                    when others =>
                        hex_5 <= "1000000";
                end case;
        end process;

        process (min_0) 
            begin
                case min_0 is 
                    when "0000" =>
                        hex_4 <= "1000000";
                    when "0001" =>
                        hex_4 <= "1111001";
                    when "0010" =>
                        hex_4 <= "0100100";
                    when "0011" =>
                        hex_4 <= "0110000";
                    when "0100" =>
                        hex_4 <= "0011001";
                    when "0101" =>
                        hex_4 <= "0010010";
                    when "0110" =>
                        hex_4 <= "0000010";
                    when "0111" =>
                        hex_4 <= "1111000";
                    when "1000" =>
                        hex_4 <= "0000000";
                    when "1001" =>
                        hex_4 <= "0011000";
                    when others =>
                        hex_4 <= "1000000";
                end case;
        end process;

        process(sec_1)
            begin
                case sec_1 is 
                    when "0000" =>
                        hex_3 <= "1000000";
                    when "0001" =>
                        hex_3 <= "1111001";
                    when "0010" =>
                        hex_3 <= "0100100";
                    when "0011" =>
                        hex_3 <= "0110000";
                    when "0100" =>
                        hex_3 <= "0011001";
                    when "0101" =>
                        hex_3 <= "0010010";
                    when "0110" =>
                        hex_3 <= "0000010";
                    when "0111" =>
                        hex_3 <= "1111000";
                    when "1000" =>
                        hex_3 <= "0000000";
                    when "1001" =>
                        hex_3 <= "0011000";
                    when others =>
                        hex_3 <= "1000000";
                end case;
        end process;

        process (sec_0)
            begin
                case sec_0 is 
                    when "0000" =>
                        hex_2 <= "1000000";
                    when "0001" =>
                        hex_2 <= "1111001";
                    when "0010" =>
                        hex_2 <= "0100100";
                    when "0011" =>
                        hex_2 <= "0110000";
                    when "0100" =>
                        hex_2 <= "0011001";
                    when "0101" =>
                        hex_2 <= "0010010";
                    when "0110" =>
                        hex_2 <= "0000010";
                    when "0111" =>
                        hex_2 <= "1111000";
                    when "1000" =>
                        hex_2 <= "0000000";
                    when "1001" =>
                        hex_2 <= "0011000";
                    when others =>
                        hex_2 <= "1000000";
                end case;
        end process;

        process (frac_1) 
            begin
                case frac_1 is 
                    when "0000" =>
                        hex_1 <= "1000000";
                    when "0001" =>
                        hex_1 <= "1111001";
                    when "0010" =>
                        hex_1 <= "0100100";
                    when "0011" =>
                        hex_1 <= "0110000";
                    when "0100" =>
                        hex_1 <= "0011001";
                    when "0101" =>
                        hex_1 <= "0010010";
                    when "0110" =>
                        hex_1 <= "0000010";
                    when "0111" =>
                        hex_1 <= "1111000";
                    when "1000" =>
                        hex_1 <= "0000000";
                    when "1001" =>
                        hex_1 <= "0011000";
                    when others =>
                        hex_1 <= "1000000";
                end case;
        end process;

        process (frac_0) 
            begin
                case frac_0 is 
                    when "0000" =>
                        hex_0 <= "1000000";
                    when "0001" =>
                        hex_0 <= "1111001";
                    when "0010" =>
                        hex_0 <= "0100100";
                    when "0011" =>
                        hex_0 <= "0110000";
                    when "0100" =>
                        hex_0 <= "0011001";
                    when "0101" =>
                        hex_0 <= "0010010";
                    when "0110" =>
                        hex_0 <= "0000010";
                    when "0111" =>
                        hex_0 <= "1111000";
                    when "1000" =>
                        hex_0 <= "0000000";
                    when "1001" =>
                        hex_0 <= "0011000";
                    when others =>
                        hex_0 <= "1000000";
                end case;
        end process;

end architecture;
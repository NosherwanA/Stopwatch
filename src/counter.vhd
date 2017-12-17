library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    port(
        clk         : in std_logic;
        en          : in std_logic;
        reset       : in std_logic;
        minutes     : out std_logic_vector(7 downto 0);
        seconds     : out std_logic_vector(7 downto 0);
        fraction    : out std_logic_vector(7 downto 0)
    );
end counter;

architecture internal of counter is

    signal sec_1                                    : integer range 0 to 5:= 0;
    signal min_1, min_0, sec_0, frac_1, frac_0      : integer range 0 to 9:= 0;
    
    begin

        actual_counter: process (clk, reset, en)
        begin
            if (reset = '0') then
                min_1 <= 0;
                min_0 <= 0;
                sec_1 <= 0;
                sec_0 <= 0;
                frac_1 <= 0;
                frac_0 <= 0;
            elsif (rising_edge(clk) and en = '1') then 
                
                if (frac_0 = 9) then
                    if (frac_1 = 9) then
                        if (sec_0 = 9) then
                            if (sec_1 = 5) then
                                if (min_0 = 9) then
                                    if (min_1 = 9) then
                                        min_1 <= 9;
                                    else
                                        min_1 <= min_1 + 1;
                                        min_0 <= 0;
                                        sec_1 <= 0;
                                        sec_0 <= 0;
                                        frac_1 <= 0;
                                        frac_0 <= 0;
                                    end if;
                                else
                                    min_0 <= min_0 + 1;
                                    sec_1 <= 0;
                                    sec_0 <= 0;
                                    frac_1 <= 0;
                                    frac_0 <= 0;
                                end if;
                            else
                                sec_1 <= sec_1 + 1;
                                sec_0 <= 0;
                                frac_1 <= 0;
                                frac_0 <= 0;
                            end if;
                        else
                            sec_0 <= sec_0 + 1;
                            frac_1 <= 0;
                            frac_0 <= 0;
                        end if;
                    else
                        frac_1 <= frac_1 + 1;
                        frac_0 <= 0;
                    end if;
                else
                    frac_0 <= frac_0 + 1;
                end if;
            end if;
        end process;

        minutes <= std_logic_vector(to_unsigned(min_1,4)) & std_logic_vector(to_unsigned(min_0,4));
        seconds <= std_logic_vector(to_unsigned(sec_1,4)) & std_logic_vector(to_unsigned(sec_0,4));
        fraction <= std_logic_vector(to_unsigned(frac_1,4)) & std_logic_vector(to_unsigned(frac_0,4));

end architecture;
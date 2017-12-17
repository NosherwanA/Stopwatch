library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clk100Hz is
    port(
        clk_in      : in std_logic;
        clk_out     : out std_logic;
        reset       : in std_logic
    );
end clk100Hz;

architecture internal of clk100Hz is
    
    signal temp     : std_logic;
    signal counter  : integer range 0 to 249999 := 0;

    begin
        freq_div: process(reset, clk_in)
        begin
            if (reset = '0') then
                temp <= '0';
                counter <= 0;
            elsif rising_edge(clk_in) then
                if (counter = 249999) then
                    temp <= not temp;
                    counter <= 0;
                else
                    counter <= counter + 1;
                end if;
            end if;
        end process;
    
    clk_out <= temp;

end architecture;
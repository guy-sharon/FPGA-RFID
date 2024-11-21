library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

use STD.textio.all;
use ieee.std_logic_textio.all;

entity DAC1BIT is
    generic (
        max_value               : integer
    );
    Port ( 
        clk_in                  : in std_logic;
        value                   : in integer;

        pinout                  : out std_logic := '0'
    );
end DAC1BIT;

architecture Behavioral of DAC1BIT is
    file file_RESULTS : text;
begin
    file_open(file_RESULTS, "output_results.txt", write_mode);
    
    process (clk_in)
        variable cnt            : integer := 0;
        variable v_OLINE        : line;
    begin

        if rising_edge(clk_in) then
            if cnt < value then
                cnt := cnt + max_value - value;
                pinout <= '1';
            else
                cnt := cnt - value;
                pinout <= '0';
            end if;

            write(v_OLINE, pinout);
            writeline(file_RESULTS, v_OLINE);
        end if;
    end process;

end Behavioral;

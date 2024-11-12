library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_div is
    generic (
            freq_in_hz  : integer;
            freq_out_hz : integer
    );
    Port ( 
            clk_in      : in std_logic;
            clk_out     : out std_logic := '0'
    );
end clk_div;

architecture Behavioral of clk_div is
    constant N : integer := freq_in_hz / (2 * freq_out_hz);
begin

    process (clk_in)
        variable cnt : integer := N-1;
    begin
        if rising_edge(clk_in) then
            cnt := cnt + 1;
            if cnt = N then
                clk_out <= not clk_out;
                cnt := 0;
            end if;
        end if;
    end process;

end Behavioral;

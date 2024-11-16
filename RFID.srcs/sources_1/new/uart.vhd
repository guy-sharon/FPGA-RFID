library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.typedefs.ALL;

entity uart is
    Port ( 
        clk_in          : in std_logic;
        msg             : in message;

        tx              : out std_logic     := '1'
    );
end uart;

architecture Behavioral of uart is
begin

    process (clk_in) is
        variable start_cnt  : integer := 0;
        variable bit_cnt    : integer := 0;
        variable byte_cnt   : integer := msg'LENGTH - 1;
        variable val_reg    : std_logic_vector(7 downto 0);
    begin
        
        if rising_edge(clk_in) then

            ------------------------------------------ SEND BIT ------------------------------------------
            if bit_cnt = 0 then
                byte_cnt := (byte_cnt + 1) mod msg'LENGTH;
                val_reg := std_logic_vector(to_unsigned(character'pos(msg(byte_cnt)),8));
                tx <= UART_START_BIT;
            elsif bit_cnt = UART_NUM_BITS_PER_SYMBOL - 1 then
                tx <= UART_STOP_BIT;
            else
                tx <= val_reg(bit_cnt-1);
            end if;
            bit_cnt := (bit_cnt + 1) mod UART_NUM_BITS_PER_SYMBOL;
            ------------------------------------------ SEND BIT ------------------------------------------


            ------------------------------------------ START SYNC ------------------------------------------
            if start_cnt < UART_START_THRESHHOLD_CLK_CYCLES then
                start_cnt := start_cnt + 1;
                bit_cnt := 0;
                tx <= '1';
            end if;
            ------------------------------------------ START SYNC ------------------------------------------
        end if;
    end process;

end Behavioral;

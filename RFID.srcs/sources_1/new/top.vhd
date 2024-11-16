library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.typedefs.ALL;

entity top is
    Port ( 
        clk_12Mhz       : in  std_logic;

        uart_tx         : out std_logic     := '1';
        pio1            : out std_logic     := '0'
    );
end top;

architecture Behavioral of top is
    signal clk_uart     : std_logic;
begin
    
    ------------------------------------------ CLOCKS ------------------------------------------
    clk_div_inst: entity work.clk_div
        generic map(freq_in_hz => MAIN_CLOCK_FREQ_HZ, freq_out_hz => UART_BAUDRATE)
        port map(clk_in => clk_12Mhz, clk_out => clk_uart);
    ------------------------------------------ CLOCKS ------------------------------------------

    ------------------------------------------ UART ------------------------------------------
    uart : entity work.uart
        port map(
            clk_in => clk_uart,
            msg    => "Hello world! ",
            tx     => uart_tx);
    ------------------------------------------ UART ------------------------------------------

    ------------------------------------------ DAC ------------------------------------------
    DAC : entity work.DAC1BIT
        generic map (max_value => 100)
        port map(
            clk_in => clk_12Mhz,
            value => 33,
            pinout => pio1);
    ------------------------------------------ DAC ------------------------------------------
end Behavioral;

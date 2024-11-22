library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.typedefs.ALL;

entity top is
    Port ( 
        clk_12Mhz       : in  std_logic;

        uart_tx         : out std_logic     := '1';
        pio27            : out std_logic     := '0'
    );
end top;

architecture Behavioral of top is
    signal clk_uart         : std_logic;
    signal rfid_sig_clk     : std_logic;

    signal sig_phase_ind    : integer := 0;
begin
    
    ------------------------------------------ CLOCKS ------------------------------------------
    uart_clk_div: entity work.clk_div
        generic map(freq_in_hz => MAIN_CLOCK_FREQ_HZ, freq_out_hz => UART_BAUDRATE)
        port map(clk_in => clk_12Mhz, clk_out => clk_uart);

    rfid_sig_clk_div: entity work.clk_div
        generic map(freq_in_hz => MAIN_CLOCK_FREQ_HZ, freq_out_hz => RFID_SIG_CLK_FREQ_HZ)
        port map(clk_in => clk_12Mhz, clk_out => rfid_sig_clk);
    ------------------------------------------ CLOCKS ------------------------------------------

    ------------------------------------------ UART ------------------------------------------
    uart : entity work.uart
        port map(
            clk_in => clk_uart,
            msg    => "Hello world! ",
            tx     => uart_tx);
    ------------------------------------------ UART ------------------------------------------

    ------------------------------------------ DAC ------------------------------------------
    process (rfid_sig_clk)
    begin
        if rising_edge(rfid_sig_clk) then
            sig_phase_ind <= (sig_phase_ind + RFID_SIG_COSINE_TABLE_STEP_SIZE) mod RFID_SIG_COSINE_TABLE_LEN;
        end if;
    end process;

    DAC : entity work.DAC1BIT
        generic map (max_value => DAC_MAX_VALUE)
        port map(
            clk_in => clk_12Mhz,
            value => RFID_SIG_COSINE_TABLE(sig_phase_ind),
            pinout => pio27);
    ------------------------------------------ DAC ------------------------------------------
    
end Behavioral;

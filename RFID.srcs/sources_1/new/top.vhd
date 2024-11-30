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
    
    
    ------------------------------------------ ADC ------------------------------------------
    -- channel should be 3 (VP , VN – Dedicated analog inputs)
    -- drp_enable should only go high for one DCLK period
    ADC : entity work.xadc_wiz_0
    port map (
        daddr_in    =>  x"03",
        den_in      => drp_enable,
        di_in       => open,
        dwe_in      => '0',
        do_out          : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
        drdy_out        : out  STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
        dclk_in         : in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
        reset_in        : in  STD_LOGIC;                         -- Reset signal for the System Monitor control logic
        busy_out        : out  STD_LOGIC;                        -- ADC Busy signal
        channel_out     : out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
        eoc_out         : out  STD_LOGIC;                        -- End of Conversion Signal
        eos_out         : out  STD_LOGIC;                        -- End of Sequence Signal
        ot_out          : out  STD_LOGIC;                        -- Over-Temperature alarm output
        vccaux_alarm_out : out  STD_LOGIC;                        -- VCCAUX-sensor alarm output
        vccint_alarm_out : out  STD_LOGIC;                        -- VCCINT-sensor alarm output
        user_temp_alarm_out : out  STD_LOGIC;                        -- Temperature-sensor alarm output
        alarm_out       : out STD_LOGIC;                         -- OR'ed output of all the Alarms
        vp_in           : in  STD_LOGIC;                         -- Dedicated Analog Input Pair
        vn_in           : in  STD_LOGIC
    );
    ------------------------------------------ ADC ------------------------------------------
    
end Behavioral;

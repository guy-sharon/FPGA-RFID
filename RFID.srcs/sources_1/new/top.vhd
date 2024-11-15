library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.typedefs.ALL;

entity top is
    Port ( 
        clk_12Mhz       : in  std_logic;
        uart_tx         : out std_logic     := '1'
    );
end top;

architecture Behavioral of top is
    signal clk_uart     : std_logic;
begin
    
    clk_div_inst: entity work.clk_div
     generic map(freq_in_hz => MAIN_CLOCK_FREQ_HZ, freq_out_hz => UART_BAUDRATE)
     port map(clk_in => clk_12Mhz, clk_out => clk_uart);

    uart : entity work.uart
        port map(clk_in => clk_uart,
                 msg    => "Hello world!\n",
                 tx     => uart_tx);

end Behavioral;

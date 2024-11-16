library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

package typedefs is

    ------------------------------------------ CLOCKS ------------------------------------------
    constant MAIN_CLOCK_FREQ_HZ                 : integer := 12e6;
    ------------------------------------------ CLOCKS ------------------------------------------


    ------------------------------------------ UART ------------------------------------------
    constant UART_BAUDRATE                      : integer := 115200;
    constant UART_START_BIT                     : std_logic := '0';
    constant UART_STOP_BIT                      : std_logic := '1';
    constant UART_NUM_BITS_PER_SYMBOL           : integer := 10;
    constant UART_START_THRESHHOLD_CLK_CYCLES   : integer := UART_BAUDRATE / 10;
    type message is array (natural range <>) of character;
    ------------------------------------------ UART ------------------------------------------

    
    
end package;

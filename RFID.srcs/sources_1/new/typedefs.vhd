library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

package typedefs is

    constant MAIN_CLOCK_FREQ_HZ         : integer := 12e6;
    constant UART_BAUDRATE              : integer := 115200;
    
    type message is array (natural range <>) of character;
    
end package;

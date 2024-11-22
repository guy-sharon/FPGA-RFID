library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use work.utils.all;

package typedefs is

    ------------------------------------------ COMMON ------------------------------------------
    constant MAIN_CLOCK_FREQ_HZ                 : integer := 12e6;
    ------------------------------------------ COMMON ------------------------------------------


    ------------------------------------------ UART ------------------------------------------
    constant UART_BAUDRATE                      : integer := 115200;
    constant UART_START_BIT                     : std_logic := '0';
    constant UART_STOP_BIT                      : std_logic := '1';
    constant UART_NUM_BITS_PER_SYMBOL           : integer := 10;
    constant UART_START_THRESHHOLD_CLK_CYCLES   : integer := UART_BAUDRATE / 10;
    type message is array (natural range <>) of character;
    ------------------------------------------ UART ------------------------------------------


    ------------------------------------------ 1-BIT DAC ------------------------------------------
    constant DAC_MAX_VALUE                      : integer := 65536;
    ------------------------------------------ 1-BIT DAC ------------------------------------------


    ------------------------------------------ RFID SIGNAL GENERATOR ------------------------------------------
    constant RFID_SIGNAL_FREQ_HZ                : integer := 1e6;
    type int_array is array (natural range <>) of integer;
    constant RFID_SIG_COSINE_TABLE_LEN          : integer := 100;
    constant RFID_SIG_COSINE_TABLE              : int_array(RFID_SIG_COSINE_TABLE_LEN-1 downto 0) := (0, 64, 258, 580, 1029, 1603, 2301, 3118, 4053, 5101, 6258, 7519, 8881, 10336, 11880, 13507, 15210, 16981, 18816, 20705, 22642, 24618, 26627, 28661, 30710, 32767, 34825, 36874, 38908, 40917, 42893, 44830, 46719, 48554, 50325, 52028, 53655, 55199, 56654, 58016, 59277, 60434, 61482, 62417, 63234, 63932, 64506, 64955, 65277, 65471, 65536, 65471, 65277, 64955, 64506, 63932, 63234, 62417, 61482, 60434, 59277, 58016, 56654, 55199, 53655, 52028, 50325, 48554, 46719, 44830, 42893, 40917, 38908, 36874, 34825, 32768, 30710, 28661, 26627, 24618, 22642, 20705, 18816, 16981, 15210, 13507, 11880, 10336, 8881, 7519, 6258, 5101, 4053, 3118, 2301, 1603, 1029, 580, 258, 64);
    constant RFID_SIG_CLK_FREQ_HZ               : integer := gcd(RFID_SIGNAL_FREQ_HZ * RFID_SIG_COSINE_TABLE_LEN, MAIN_CLOCK_FREQ_HZ);
    constant RFID_SIG_COSINE_TABLE_STEP_SIZE    : integer := (RFID_SIGNAL_FREQ_HZ * RFID_SIG_COSINE_TABLE_LEN) / RFID_SIG_CLK_FREQ_HZ;
    ------------------------------------------ RFID SIGNAL GENERATOR ------------------------------------------
    
end package;

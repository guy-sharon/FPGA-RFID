library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.typedefs;

entity uart is
    Port ( 
        clk_in          : in std_logic;
        msg             : in message;

        tx              : out std_logic
    );
end uart;

architecture Behavioral of uart is
    signal val_reg      : std_logic_vector(7 downto 0);

    signal msg_reg      : message(0 to msg'LENGTH-1);
    signal msg_ind      : integer range 0 to msg'LENGTH         := 0;

    signal sync_cnt     : integer range 0 to UART_BAUDRATE-1    := 0;
    signal sync         : std_logic                             := '1';
    signal sync_pending : std_logic                             := '0';
begin

    process (clk_in) is
        variable bit_cnt    : integer := 0;
    begin
        
        if rising_edge(clk_in) then
            tx <= val_reg(bit_cnt-1);

            if bit_cnt = 9 then
                bit_cnt := 0;
            else
                bit_cnt := bit_cnt + 1;
            end if;
        end if;
    end process;

end Behavioral;

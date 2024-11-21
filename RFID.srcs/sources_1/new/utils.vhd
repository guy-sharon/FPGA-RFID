library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package utils is
    pure function gcd(a : integer; b : integer) return integer;
end package utils;

package body utils is
    pure function gcd(a : integer; b : integer) return integer is
    begin
        if b = 0 then
            return a;
        else
            return gcd(b, a mod b);
        end if;
    end function;
end package body;

library ieee;
use ieee.std_logic_1164.all;

entity DFlipFlop is
port (
    clock   : in std_ulogic;
    enable  : in std_ulogic;
    reset   : in std_ulogic;
    d       : in std_ulogic;
    q       : out std_ulogic
);
end entity DFlipFlop;

architecture behavioral of DFlipFlop is
begin

    process(clock)
    begin
        if rising_edge(clock) then
            if reset = '1' then
		q <= '0';
            else if en = '1' then
                q <= d;
            end if;
        end if;
    end process;

end architecture behavioral;



library ieee;
use ieee.std_logic_1164.all;

entity GenericDFlipFlop is
generic (
    width : natural    := 8;
    edge  : std_ulogic := '1'
);
port (
    clock   : in std_ulogic;
    enable  : in std_ulogic;
    reset   : in std_ulogic;
    d : in std_ulogic_vector(width - 1 downto 0);
    q : out std_ulogic_vector(width - 1 downto 0)
);
end entity GenericDFlipFlop;

architecture behavioral of GenericDFlipFlop is
begin

    process(clock, reset)
    begin
        if clk'event and clock = edge and clk'last_value = not edge then
	    if reset = '1' then
		q <= '0';
            else if enable = '1' then
                q <= d;
            end if;
        end if;
    end process;

end architecture behavioral;


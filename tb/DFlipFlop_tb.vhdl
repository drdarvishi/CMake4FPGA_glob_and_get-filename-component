library ieee;
use ieee.std_logic_1164.all;

entity DFlipFlop_tb is
  generic (
    en_pattern : std_ulogic_vector := "0000101110101010";
    d_pattern  : std_ulogic_vector := "0100111001011000";
    time_out   : time := 1 us
    );
    

end entity DFlipFlop_tb;

architecture simonly of DFlipFlop_tb is
  signal clock : std_ulogic := '0';
  signal enable  : std_ulogic := '0';
  signal d   : std_ulogic := '0';
  signal q   : std_ulogic := '0';

  constant clock_period : time := 10 ns;
  signal en_index : natural := 0;
  signal d_index : natural := 0;

  signal d_last : std_ulogic := '0';
  signal q_last : std_ulogic := '0';
  signal en_last : std_ulogic := '0';

  signal stop : boolean := false;
  signal is_initialized : std_ulogic := '0';
begin
  clock_proc : process
  begin
    wait for clock_period/2;
    clock <= '0';
    wait for clock_period/2;
    clock <= '1';
    if (stop) then
      wait;
    end if;
  end process;

  timeout_proc: process
  begin
    wait for time_out;
  end process;
    
  uut: entity work.DFlipFlop
    port map (
      clock => clock,
      enable  => enable,
      d   => d,
      q   => q
      );

  stim_proc : process(clock)
  begin
    if rising_edge(clock) then
      D <= d_pattern(d_index);
      enable <= en_pattern(en_index);
      d_index <= (d_index + 1) mod d_pattern'length;
      en_index <= (en_index + 1) mod en_pattern'length;
    end if;
  end process;

  check_proc : process(clock)
  begin
    if rising_edge(clock) then
      if en_last = '1' then
        assert (q = d_last) report "failed assignment" severity error;
      elsif (is_initialized = '1') then
        assert (q = q_last) report "failed hold" severity error;
      end if;
      d_last <= d;
      q_last <= q;
      en_last <= en;
      if (enable = '1') then
        is_initialized <= '1';
      end if;
    end if;
  end process;      

end architecture simonly;

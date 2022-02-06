library ieee;
use ieee.std_logic_1164.all;

entity clock_divider is
  generic
  (
    frequency: integer := 50000000;
    prescaler: integer := 25000000 -- output_frequency = frequency/prescaler
  );
  port
  (
    clock_in: in std_logic;
    clock_out: out std_logic
  );
end entity;

architecture behavior of clock_divider is
begin
  process (clock_in)
    variable counter: integer := 0;
  begin
    if rising_edge(clock_in) then
      if counter < frequency/prescaler then
        counter := counter + 1;
        clock_out <= '0';
      elsif counter < frequency then
        counter := counter + 1;
        clock_out <= '1';
      end if;

      if counter = frequency then
        counter := 0;
      end if;
    end if;
  end process;
end architecture;

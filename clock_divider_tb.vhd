library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity clock_divider_tb is
end;

architecture bench of clock_divider_tb is

  component clock_divider
    generic
    (
      frequency: integer := 50000000;
      prescaler: integer := 25000000
    );
    port
    (
      clock_in: in std_logic;
      clock_out: out std_logic
    );
  end component;

  signal clock_in: std_logic;
  signal clock_out: std_logic ;

  constant clock_period: time := 20 ns;
  signal stop_the_clock: boolean;

begin

  uut: clock_divider generic map ( frequency => 50000000,
                                   prescaler =>  25000000)
                        port map ( clock_in  => clock_in,
                                   clock_out => clock_out );

  stimulus: process
  begin

    wait for 20 ns;
    clock_in <= '1';
    wait for 20 ns;
    clock_in <= '0';
    wait;


    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clock_in <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;

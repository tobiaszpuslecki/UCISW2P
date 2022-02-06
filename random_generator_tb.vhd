library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity random_generator_tb is
end;

architecture bench of random_generator_tb is

  component random_generator
    port (
      reset    : in  std_logic;
      clock      : in  std_logic;
      random_bit_out : out std_logic
      random_out : out std_logic_vector(41 to 0));
    );
  end component;

  signal reset: std_logic;
  signal clock: std_logic;
  signal random_bit_out: std_logic random_out : out std_logic_vector(41 to 0));

  constant clock_period: time := 20 ns;
  signal stop_the_clock: boolean;

begin

  uut: random_generator port map ( reset          => reset,
                           clock          => clock,
                           random_bit_out => random_bit_out );

  stimulus: process
  begin

    -- begin
    --   wait until (reset = '0');
    --   for i in 0 to 100 loop -- ?
    --     wait until (clock = '1');
    --   end loop;


      clock <= not clock after clock_period/2;
      reset <= '0' after clock_period*10;
      stop_the_clock <= true after clock_period*8000;

    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clock <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;

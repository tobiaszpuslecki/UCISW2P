library ieee;
use ieee.std_logic_1164.all;

entity random_generator is
  port (
    reset    : in  std_logic;
    clock      : in  std_logic;
    random_bit_out : out std_logic
    random_out : out std_logic_vector(41 to 0));
  );
end entity;

architecture rtl of random_generator is
  signal lfsr       : std_logic_vector (41 downto 0);
  signal feedback 	: std_logic;

begin

  -- random bits xored, maybe expanded
  feedback <= not(lfsr(3) xor lfsr(2) xor lfsr(32));

  main_process : process (clock)
  begin
    if (rising_edge(clock)) then
      if (reset = '1') then
        lfsr <= (others => '0');
      else
        lfsr <= lfsr(41 downto 0) & feedback;
      end if;
    end if;
  end process main_process;

  random_bit_out <= lfsr(3);
  random_out <= lfsr;

end architecture;

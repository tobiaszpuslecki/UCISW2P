----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:44:51 04/26/2020 
-- Design Name: 
-- Module Name:    RNG - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RNG is
    Port ( RES : out  STD_LOGIC_VECTOR (7 downto 0);
	 clk : in STD_LOGIC;
	 reset : in STD_LOGIC;
	 en : in STD_LOGIC;
	 seed : in STD_LOGIC_VECTOR (7 downto 0);
	 check: out STD_LOGIC);
end RNG;

architecture Behavioral of RNG is

signal random_number: STD_LOGIC_VECTOR(7 downto 0) := x"01";

begin

PROCESS(clk)
variable tmp : STD_LOGIC := '0';
BEGIN

IF rising_edge(clk) THEN
   IF (reset='1') THEN
        random_number <= seed;
   ELSIF en = '1' THEN
      tmp := random_number(4) XOR random_number(3) XOR random_number(2) XOR random_number(0);
      random_number <= tmp & random_number(7 downto 1);
   END IF;

END IF;
END PROCESS;
check <= Qt(7);
 RES <= random_number;
 
 
end Behavioral;


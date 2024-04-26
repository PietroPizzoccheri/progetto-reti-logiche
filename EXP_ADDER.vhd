
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity EXP_ADDER is
    Port ( 
        E1 : in  STD_LOGIC_VECTOR (7 downto 0);
        E2 : in  STD_LOGIC_VECTOR (7 downto 0);
        sum : out  STD_LOGIC_VECTOR (8 downto 0)
    );
end EXP_ADDER;

architecture RTL of EXP_ADDER is

component CLA_8 is
    port (
      X, Y : in  std_logic_vector(8 - 1 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(8 - 1 downto 0);
      Cout : out std_logic
    );
  end component;

begin

ADDER: CLA_8
    port map (
      X    => E1,
      Y    => E2,
      S    => sum(7 downto 0),
      Cin  => '0',
      Cout => sum(8)
    );

end RTL;
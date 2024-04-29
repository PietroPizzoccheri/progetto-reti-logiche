
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity BIAS_SUBTRACTOR is
  port (
    EXP  : in  STD_LOGIC_VECTOR(8 downto 0);
    BIAS : in  STD_LOGIC_VECTOR(8 downto 0);
    S    : out STD_LOGIC_VECTOR(9 downto 0)
  );
end entity;

architecture RTL of BIAS_SUBTRACTOR is

  component CLA_9 is
    port (
      X, Y : in  std_logic_vector(9 - 1 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(9 - 1 downto 0);
      Cout : out std_logic
    );
  end component;

begin

  ADDER: CLA_9
    port map (
      X    => EXP,
      Y    => not BIAS,
      S    => S(8 downto 0),
      Cin  => '1',
      Cout => S(9)
    );

end architecture;


library IEEE;
  use IEEE.STD_LOGIC_1164.all;

  -- 6/7 ns to compute

entity BIAS_SUBTRACTOR is
  port (
    EXP  : in  STD_LOGIC_VECTOR(8 downto 0);
    BIAS : in  STD_LOGIC_VECTOR(8 downto 0);
    S    : out STD_LOGIC_VECTOR(9 downto 0)
  );
end entity;

-- Sums EXP and the 2's complement of BIAS to get the bias subtracted value (in 2's complement)

architecture RTL of BIAS_SUBTRACTOR is

  component CLA_10 is
    port (
      X, Y : in  std_logic_vector(9 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(9 downto 0);
      Cout : out std_logic
    );
  end component;

  signal EXP_10  : std_logic_vector(9 downto 0);
  signal BIAS_10 : std_logic_vector(9 downto 0);
  signal C1_BIAS : std_logic_vector(9 downto 0);

begin
  -- EXP and BIAS are 9 bits long, so we need to extend them to 10 bits
  -- They are unsigned, so we concatenate 0 to the MSB
  EXP_10  <= "0" & EXP;
  BIAS_10 <= "0" & BIAS;
  C1_BIAS <= not BIAS_10;

  adder: CLA_10
    port map (
      X    => EXP_10,
      Y    => C1_BIAS,
      S    => S,
      Cin  => '1', -- for 2's complement
      Cout => open
    );
end architecture;

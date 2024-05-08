
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

  -- 12 ns to compute

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
      X, Y : in  std_logic_vector(8 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(8 downto 0);
      Cout : out std_logic
    );
  end component;

  signal COUT_TEMP : std_logic;
  signal TEMP_SUM  : std_logic_vector(8 downto 0);
begin
  adder: CLA_9
    port map (
      X    => EXP,
      Y    => not BIAS,
      S    => TEMP_SUM(8 downto 0),
      Cin  => '1',
      Cout => COUT_TEMP
    );

  S(8 downto 0) <= TEMP_SUM(8 downto 0);
  -- BIAS will always be negative since we are subtracting it
  S(9) <= COUT_TEMP when (EXP(8) = '1') and ((TEMP_SUM(8) = '1' and COUT_TEMP = '0') or (TEMP_SUM(8) = '0' and COUT_TEMP = '1')) else TEMP_SUM(8);
  
end architecture;

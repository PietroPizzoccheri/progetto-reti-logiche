
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

  -- 12 ns to compute

 -- sums 2 unsigned numbers and the result is signed
entity BIAS_SUBTRACTOR is
  port (
    EXP  : in  STD_LOGIC_VECTOR(8 downto 0);
    BIAS : in  STD_LOGIC_VECTOR(8 downto 0);
    S    : out STD_LOGIC_VECTOR(9 downto 0)
  );
end entity;

architecture RTL of BIAS_SUBTRACTOR is

  component CLA_12 is
    port (
      X, Y : in  std_logic_vector(11 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(11 downto 0);
      Cout : out std_logic
    );
  end component;

  signal COUT_TEMP : std_logic;
  signal EXP_12    : std_logic_vector(11 downto 0);
  signal BIAS_12   : std_logic_vector(11 downto 0);
  signal C1_BIAS   : std_logic_vector(11 downto 0);
  signal TEMP_SUM  : std_logic_vector(11 downto 0);

begin

  EXP_12  <= "000" & EXP;
  BIAS_12 <= "000" & BIAS;
  C1_BIAS <= not BIAS_12;
  adder: CLA_12
    port map (
      X    => EXP_12,
      Y    => C1_BIAS,
      S    => TEMP_SUM(11 downto 0),
      Cin  => '1',
      Cout => COUT_TEMP
    );

  S(8 downto 0) <= TEMP_SUM(8 downto 0);
  

  S(9) <= TEMP_SUM(9) when ((EXP(8) = '1' and C1_BIAS(8) = '1') or (EXP(8) = '0' and C1_BIAS(8) = '0')) and ((TEMP_SUM(8) = '1' and TEMP_SUM(9) = '0') or (TEMP_SUM(8) = '0' and TEMP_SUM(9) = '1')) else TEMP_SUM(8);

  -- S(9) <= COUT_TEMP when (EXP(8) = '1') and ((TEMP_SUM(8) = '1' and COUT_TEMP = '0') or (TEMP_SUM(8) = '0' and COUT_TEMP = '1')) else TEMP_SUM(8);
end architecture;

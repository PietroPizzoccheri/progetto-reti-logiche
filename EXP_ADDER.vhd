
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

  -- 12 ns to compute correctly

entity EXP_ADDER is
  port (
    E1  : in  STD_LOGIC_VECTOR(7 downto 0);
    E2  : in  STD_LOGIC_VECTOR(7 downto 0);
    SUM : out STD_LOGIC_VECTOR(8 downto 0)
  );
end entity;

architecture RTL of EXP_ADDER is

  component CLA_8 is
    port (
      X, Y : in  std_logic_vector(8 - 1 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(8 - 1 downto 0);
      Cout : out std_logic
    );
  end component;

  signal COUT_TEMP                    : std_logic;
  signal TEMP_SUM                     : std_logic_vector(7 downto 0);
  signal EXP_1_IS_ZERO, EXP_2_IS_ZERO : std_logic;
  signal TEMP_E1, TEMP_E2             : std_logic_vector(8 - 1 downto 0);
begin
  EXP_1_IS_ZERO <= not(E1(0) or E1(1) or E1(2) or E1(3) or E1(4) or E1(5) or E1(6) or E1(7));
  EXP_2_IS_ZERO <= not(E2(0) or E2(1) or E2(2) or E2(3) or E2(4) or E2(5) or E2(6) or E2(7));

  -- If the number was denormalized (exponent is zero), then we need to set his exponent to -126
  TEMP_E1 <= E1 when EXP_1_IS_ZERO = '0' else "00000001";
  TEMP_E2 <= E2 when EXP_2_IS_ZERO = '0' else "00000001";

  adder: CLA_8
    port map (
      X    => TEMP_E1,
      Y    => TEMP_E2,
      S    => TEMP_SUM(7 downto 0),
      Cin  => '0',
      Cout => COUT_TEMP
    );

  SUM(7 downto 0) <= TEMP_SUM;
  -- We need to consider the Carry in case of overflow, othwerwise we extend the sign of the sum
  -- There is an "overflow" only if the signs of the operands are identical AND the sign bit of the result and that carry-out are not identical. If the signs of the operands are different, then there cannot be an overflow, regardless of the state of the carry-out
  SUM(8) <= COUT_TEMP;
end architecture;

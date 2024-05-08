
library IEEE;
  use IEEE.STD_LOGIC_1164.all;


entity FINAL_EXP_CALCULATOR is
  port (
    EXP  : in  STD_LOGIC_VECTOR(9 downto 0);
    OFFSET : in  STD_LOGIC_VECTOR(4 downto 0);
    SUB : in STD_LOGIC;
    S    : out STD_LOGIC_VECTOR(9 downto 0)
  );
end entity;

architecture RTL of FINAL_EXP_CALCULATOR is

  component CLA_12 is
    port (
      X, Y : in  std_logic_vector(11 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(11 downto 0);
      Cout : out std_logic
    );
  end component;

  signal EXP_12    : std_logic_vector(11 downto 0);
  signal OFFSET_12   : std_logic_vector(11 downto 0);
  signal OFFSET_TO_ADD   : std_logic_vector(11 downto 0);
  signal TEMP_SUM  : std_logic_vector(11 downto 0);
  signal extended_SUB : std_logic_vector(11 downto 0);
  signal SUB_SIG : std_logic;

begin

  EXP_12  <= EXP(9) & EXP(9)  & EXP; --extend the sign
  OFFSET_12 <= "0000000" & OFFSET;
  extended_SUB <= (others => SUB);
  OFFSET_TO_ADD <= extended_SUB xor OFFSET_12;
  SUB_SIG <= SUB;

  
  adder: CLA_12
    port map (
      X    => EXP_12,
      Y    => OFFSET_TO_ADD,
      S    => TEMP_SUM(11 downto 0),
      Cin  => SUB_SIG,
      Cout => open
    );

  S(8 downto 0) <= TEMP_SUM(8 downto 0);
  
  S(9) <= TEMP_SUM(9) when ((EXP(8) = '1' and OFFSET_TO_ADD(8) = '1') or (EXP(8) = '0' and OFFSET_TO_ADD(8) = '0')) and ((TEMP_SUM(8) = '1' and TEMP_SUM(9) = '0') or (TEMP_SUM(8) = '0' and TEMP_SUM(9) = '1')) else TEMP_SUM(8);

  -- S(9) <= COUT_TEMP when (EXP(8) = '1') and ((TEMP_SUM(8) = '1' and COUT_TEMP = '0') or (TEMP_SUM(8) = '0' and COUT_TEMP = '1')) else TEMP_SUM(8);
end architecture;

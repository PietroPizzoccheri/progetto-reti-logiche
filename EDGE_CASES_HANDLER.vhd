
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

  -- 7/8 ns max to compute correctly

entity EDGE_CASES_HANDLER is
  port (
    X           : in  std_logic_vector(31 downto 0);
    Y           : in  std_logic_vector(31 downto 0);
    zero        : out std_logic;
    invalid     : out std_logic;
    inf         : out std_logic;
    both_denorm : out std_logic
  );

end entity;

-- Computes the special cases of the IEEE 754 standard

architecture RTL of EDGE_CASES_HANDLER is

  component OPERANDS_SPLITTER is
    port (
      float  : in  STD_LOGIC_VECTOR(31 downto 0);
      sign   : out STD_LOGIC;
      exp    : out STD_LOGIC_VECTOR(7 downto 0);
      mantix : out STD_LOGIC_VECTOR(22 downto 0));
  end component;

  component FLAG_SETTER is
    port (
      exp    : in  std_logic_vector(7 downto 0);
      mantix : in  std_logic_vector(22 downto 0);
      zero   : out std_logic;
      norm   : out std_logic;
      denorm : out std_logic;
      nan    : out std_logic;
      inf    : out std_logic
    );
  end component;

  signal exp_X, exp_Y                                                                   : std_logic_vector(7 downto 0);
  signal mantix_X, mantix_Y                                                             : std_logic_vector(22 downto 0);
  signal zero_X, zero_Y, inf_X, inf_Y, nan_X, nan_Y, norm_X, norm_Y, denorm_X, denorm_Y : std_logic;

begin
  -- split X and Y inputs into sign, exponent and mantissa
  operand_splitter_X: OPERANDS_SPLITTER
    port map (float  => X,
              sign   => open,
              exp    => exp_X,
              mantix => mantix_X);

  operand_splitter_Y: OPERANDS_SPLITTER
    port map (float  => Y,
              sign   => open,
              exp    => exp_Y,
              mantix => mantix_Y);

  -- set flags for X and Y
  flag_setter_X: FLAG_SETTER
    port map (exp    => exp_X,
              mantix => mantix_X,
              zero   => zero_X,
              norm   => norm_X,
              denorm => denorm_X,
              nan    => nan_X,
              inf    => inf_X);

  flag_setter_Y: FLAG_SETTER
    port map (exp    => exp_Y,
              mantix => mantix_Y,
              zero   => zero_Y,
              norm   => norm_Y,
              denorm => denorm_Y,
              nan    => nan_Y,
              inf    => inf_Y);

  compute: process (zero_X, zero_Y, inf_X, inf_Y, nan_X, nan_Y, norm_X, norm_Y, denorm_X, denorm_Y)
  begin
    -- check for edge case combinations
    zero <= (zero_X and norm_Y) or (norm_X and zero_Y) or (zero_X and denorm_Y) or (denorm_X and zero_Y) or (zero_X and zero_Y);
    invalid <= (nan_X and norm_Y) or (norm_X and nan_Y) or (nan_X and denorm_Y) or (denorm_X and nan_Y) or (nan_X and zero_Y) or (zero_X and nan_Y) or (nan_X and inf_Y) or (inf_x and nan_Y) or (zero_X and inf_Y) or (inf_X and zero_Y) or (nan_X and nan_Y);
    inf <= (inf_X and norm_Y) or (norm_X and inf_Y) or (inf_X and denorm_Y) or (denorm_X and inf_Y) or (inf_X and inf_Y) or (inf_Y and inf_X);
    both_denorm <= (denorm_X and denorm_Y);
  end process;
end architecture;


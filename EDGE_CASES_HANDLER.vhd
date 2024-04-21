
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity EDGE_CASES_HANDLER is
  port (
    X       : in  std_logic_vector(31 downto 0);
    Y       : in  std_logic_vector(31 downto 0);
    zero    : out std_logic;
    invalid : out std_logic;
    inf     : out std_logic
  );

end entity;

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

  signal sign_X, sign_Y     : std_logic;
  signal exp_X, exp_Y       : std_logic_vector(7 downto 0);
  signal mantix_X, mantix_Y : std_logic_vector(22 downto 0);
  signal f                  : std_logic_vector(2 downto 0); -- function of the truth table 
  signal X_case, Y_case     : std_logic_vector(4 downto 0); -- truth table cases
  constant NaN      : std_logic_vector(4 downto 0) := "00001";
  constant INFINITY : std_logic_vector(4 downto 0) := "00010";
  constant ZERO_CONST    : std_logic_vector(4 downto 0) := "00100";
  constant DENORM   : std_logic_vector(4 downto 0) := "01000";
  constant NORM     : std_logic_vector(4 downto 0) := "10000";

  signal zero_X, zero_Y, inf_X, inf_Y, nan_X, nan_Y, norm_X, norm_Y, denorm_X, denorm_Y : std_logic;

begin
  -- TODO: Move operand splitter outside
  -- split X and Y inputs into sign, exponent and mantissa
  operand_splitter_X: OPERANDS_SPLITTER
    port map (float  => X,
              sign   => sign_X,
              exp    => exp_X,
              mantix => mantix_X);

  operand_splitter_Y: OPERANDS_SPLITTER
    port map (float  => Y,
              sign   => sign_Y,
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

  -- check for edge case combinations
  -- zero    <= (zero_X and norm_Y) or (norm_X and zero_Y) or (zero_X and denorm_Y) or (denorm_X and zero_Y) or (zero_X and zero_Y);
  -- invalid <= (nan_X and norm_Y) or (norm_X and nan_Y) or (nan_X and denorm_Y) or (denorm_X and nan_Y) or (nan_X and zero_Y) or (zero_X and nan_Y) or (nan_X and inf_Y) or (inf_x and nan_Y) or (zero_X and inf_Y) or (inf_X and zero_Y) or (nan_X and nan_Y);
  -- inf     <= (inf_X and norm_Y) or (norm_X and inf_Y) or (inf_X and denorm_Y) or (denorm_X and inf_Y) or (inf_X and inf_Y) or (inf_Y and inf_X);
  X_case <= norm_X & denorm_X & zero_X & inf_X & nan_X; -- truth table for X
  Y_case <= norm_Y & denorm_X & zero_Y & inf_Y & nan_Y; -- truth table for Y

  -- truth table 
  f <= "001" when X_case = NaN and Y_case = NaN else
       "001" when X_case = NaN and Y_case = INFINITY else
       "001" when X_case = NaN and Y_case = ZERO_CONST else
       "001" when X_case = NaN and Y_case = DENORM else
       "001" when X_case = NaN and Y_case = NORM else

       "001" when X_case = INFINITY and Y_case = NaN else
       "010" when X_case = INFINITY and Y_case = INFINITY else
       "001" when X_case = INFINITY and Y_case = ZERO_CONST else
       "010" when X_case = INFINITY and Y_case = DENORM else
       "010" when X_case = INFINITY and Y_case = NORM else

       "001" when X_case = ZERO_CONST and Y_case = NaN else
       "001" when X_case = ZERO_CONST and Y_case = INFINITY else
       "100" when X_case = ZERO_CONST and Y_case = ZERO_CONST else
       "100" when X_case = ZERO_CONST and Y_case = DENORM else
       "100" when X_case = ZERO_CONST and Y_case = NORM else

       "001" when X_case = DENORM and Y_case = NaN else
       "010" when X_case = DENORM and Y_case = INFINITY else
       "100" when X_case = DENORM and Y_case = ZERO_CONST else
       "000" when X_case = DENORM and Y_case = DENORM else
       "000" when X_case = DENORM and Y_case = NORM else

       "001" when X_case = NORM and Y_case = NaN else
       "010" when X_case = NORM and Y_case = INFINITY else
       "100" when X_case = NORM and Y_case = ZERO_CONST else
       "000" when X_case = NORM and Y_case = DENORM else
       "000" when X_case = NORM and Y_case = NORM;

  invalid <= f(0);
  inf     <= f(1);
  zero    <= f(2);

end architecture;

library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity TEST_FINALE is
  port (
    X       : in  STD_LOGIC_VECTOR(31 downto 0);
    Y       : in  STD_LOGIC_VECTOR(31 downto 0);
    P       : out STD_LOGIC_VECTOR(31 downto 0);
    invalid : out STD_LOGIC
  );
end entity;

architecture RTL of TEST_FINALE is

  component OPERANDS_SPLITTER is
    port (
      float  : in  STD_LOGIC_VECTOR(31 downto 0);
      sign   : out STD_LOGIC;
      exp    : out STD_LOGIC_VECTOR(7 downto 0);
      mantix : out STD_LOGIC_VECTOR(22 downto 0));
  end component;

  component EDGE_CASES_HANDLER is
    port (
      X           : in  std_logic_vector(31 downto 0);
      Y           : in  std_logic_vector(31 downto 0);
      zero        : out std_logic;
      invalid     : out std_logic;
      inf         : out std_logic;
      both_denorm : out std_logic
    );
  end component;

  component EXP_ADDER is
    port (
      E1  : in  STD_LOGIC_VECTOR(7 downto 0);
      E2  : in  STD_LOGIC_VECTOR(7 downto 0);
      SUM : out STD_LOGIC_VECTOR(8 downto 0)
    );
  end component;

  component CLA_8
    port (
      X    : in  std_logic_vector(7 downto 0);
      Y    : in  std_logic_vector(7 downto 0);
      S    : out std_logic_vector(7 downto 0);
      Cin  : in  std_logic;
      Cout : out std_logic
    );
  end component;

  component CLA_12 is
    port (
      X, Y : in  std_logic_vector(11 downto 0);
      S    : out std_logic_vector(11 downto 0);
      Cin  : in  std_logic;
      Cout : out std_logic
    );
  end component;

  component BIAS_SUBTRACTOR is
    port (
      EXP  : in  STD_LOGIC_VECTOR(8 downto 0);
      BIAS : in  STD_LOGIC_VECTOR(8 downto 0);
      S    : out STD_LOGIC_VECTOR(9 downto 0)
    );
  end component;

  component MANTIX_FIXER is
    port (
      MANTIX     : in  STD_LOGIC_VECTOR(22 downto 0);
      exp        : in  STD_LOGIC_VECTOR(7 downto 0);
      MANTIX_OUT : out STD_LOGIC_VECTOR(23 downto 0); -- Returns the Significant Normalized (The mantix with a 1 in front of it)
      OFFSET     : out STD_LOGIC_VECTOR(4 downto 0)   -- Returns the offset of the mantix
    );
  end component;

  component MUL_24_CLA is
    port (
      X : in  std_logic_vector(23 downto 0);
      Y : in  std_logic_vector(23 downto 0);
      P : out std_logic_vector(47 downto 0)
    );
  end component;

  component ROUNDER is
    port (
      MANTIX  : in  STD_LOGIC_VECTOR(47 downto 0);
      SHIFTED : out STD_LOGIC_VECTOR(22 downto 0);
      OFFSET  : out STD_LOGIC_VECTOR(4 downto 0);
      SUB     : out STD_LOGIC
    );
  end component;

  component RESULT_FIXER is
    port (
      INTERMEDIATE_EXP    : in  STD_LOGIC_VECTOR(9 downto 0);
      INTERMEDIATE_MANTIX : in  STD_LOGIC_VECTOR(22 downto 0);
      EXP                 : out STD_LOGIC_VECTOR(7 downto 0);
      MANTIX              : out STD_LOGIC_VECTOR(22 downto 0)
    );
  end component;

  component OUTPUT_LOGIC is
    port (
      result_in          : in  std_logic_vector(31 downto 0);
      zero               : in  std_logic;
      invalid_in         : in  std_logic;
      inf                : in  std_logic;
      overflow_underflow : in  std_logic;
      result_out         : out std_logic_vector(31 downto 0);
      invalid_out        : out std_logic
    );
  end component;

  component FINAL_EXP_CALCULATOR is
    port (
      EXP    : in  STD_LOGIC_VECTOR(9 downto 0);
      OFFSET : in  STD_LOGIC_VECTOR(4 downto 0);
      SUB    : in  STD_LOGIC;
      S      : out STD_LOGIC_VECTOR(9 downto 0)
    );
  end component;

  signal sign : STD_LOGIC;

  signal sign_x, sign_y                     : STD_LOGIC;
  signal initial_exp_x, initial_exp_y       : STD_LOGIC_VECTOR(7 downto 0);
  signal initial_mantix_x, initial_mantix_y : STD_LOGIC_VECTOR(22 downto 0);

  signal significant_mantix_x, significant_mantix_y : STD_LOGIC_VECTOR(23 downto 0);
  signal offset_x, offset_y                         : STD_LOGIC_VECTOR(4 downto 0);
  signal offset_to_subtract                         : STD_LOGIC_VECTOR(7 downto 0);

  signal offset_x_8, offset_y_8 : STD_LOGIC_VECTOR(7 downto 0);

  signal bias_8 : STD_LOGIC_VECTOR(7 downto 0);

  signal bias : STD_LOGIC_VECTOR(8 downto 0);

  signal mantix_product : STD_LOGIC_VECTOR(47 downto 0);

  signal zero_flag, invalid_flag, inf_flag, both_denorm_flag : STD_LOGIC;

  signal exponents_sum : STD_LOGIC_VECTOR(8 downto 0);

  signal intermediate_exp : STD_LOGIC_VECTOR(9 downto 0);

  signal intermediate_exp_1 : STD_LOGIC_VECTOR(11 downto 0);

  signal offset_from_rounder : STD_LOGIC_VECTOR(11 downto 0);

  signal fixed_exp    : STD_LOGIC_VECTOR(7 downto 0);
  signal fixed_mantix : STD_LOGIC_VECTOR(22 downto 0);

  signal rounded_mantix     : STD_LOGIC_VECTOR(22 downto 0);
  signal rounded_exp        : STD_LOGIC_VECTOR(9 downto 0);
  signal rounder_sub        : STD_LOGIC;
  signal rounder_offset     : STD_LOGIC_VECTOR(4 downto 0);
  signal rounder_sub_vector : STD_LOGIC_VECTOR(11 downto 0);

  signal temp_result : STD_LOGIC_VECTOR(31 downto 0);
begin
  oppsX: OPERANDS_SPLITTER port map (X, sign_x, initial_exp_x, initial_mantix_x);
  oppsY: OPERANDS_SPLITTER port map (Y, sign_y, initial_exp_y, initial_mantix_y);

  sign <= sign_x xor sign_y;
  
  edge_cases: EDGE_CASES_HANDLER port map (X, Y, zero_flag, invalid_flag, inf_flag, both_denorm_flag);

  mantix_fixer_x: MANTIX_FIXER port map (initial_mantix_x, initial_exp_x, significant_mantix_x, offset_x);

  mantix_fixer_y: MANTIX_FIXER port map (initial_mantix_y, initial_exp_y, significant_mantix_y, offset_y);

  offset_y_8         <= "000" & offset_y;
  offset_x_8         <= "000" & offset_x;
  offset_to_subtract <= offset_y_8 or offset_x_8;

  mantix_multiplier: MUL_24_CLA port map (significant_mantix_x, significant_mantix_y, mantix_product);

  exp_add: EXP_ADDER port map (initial_exp_x, initial_exp_y, exponents_sum);

  --bias_calc: CLA_8 port map (X => "01111111", Y => offset_to_subtract, S => bias_8, Cin => '0', Cout => bias(8));

  --bias(7 downto 0) <= bias_8;

  bias_sub: BIAS_SUBTRACTOR port map (exponents_sum, "001111111", intermediate_exp);

  roundr: ROUNDER port map (mantix_product, rounded_mantix, rounder_offset, rounder_sub);

  exp_calc: FINAL_EXP_CALCULATOR port map (intermediate_exp, rounder_offset, rounder_sub, rounded_exp);

  result_fix: RESULT_FIXER port map (rounded_exp, rounded_mantix, fixed_exp, fixed_mantix);

  temp_result <= sign & fixed_exp & fixed_mantix;

  output_l: OUTPUT_LOGIC port map (temp_result, zero_flag, invalid_flag, inf_flag, both_denorm_flag, P, invalid);

end architecture;


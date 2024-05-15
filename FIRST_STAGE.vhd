
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity FIRST_STAGE is
  port (
    X, Y                            : in  std_logic_vector(31 downto 0);
    zero, invalid, inf, both_denorm : out std_logic;
    sign                            : out std_logic;
    exp_x, exp_y                    : out std_logic_vector(7 downto 0);
    fixed_mantix_x, fixed_mantix_y  : out std_logic_vector(23 downto 0)
  );
end entity;

architecture RTL of FIRST_STAGE is

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

  component MANTIX_FIXER is
    port (
      MANTIX     : in  STD_LOGIC_VECTOR(22 downto 0);
      exp        : in  STD_LOGIC_VECTOR(7 downto 0);
      MANTIX_OUT : out STD_LOGIC_VECTOR(23 downto 0)
    );
  end component;

  signal SIGN_X, SIGN_Y     : std_logic;
  signal temp_exp_x, temp_exp_y : std_logic_vector(7 downto 0);
  signal mantix_x, mantix_y : std_logic_vector(22 downto 0);
  signal fixed_mantix_x_temp, fixed_mantix_y_temp : std_logic_vector(23 downto 0);

begin

  SPLITTER_X: OPERANDS_SPLITTER port map (X, SIGN_X, temp_exp_x, mantix_x);
  SPLITTER_Y: OPERANDS_SPLITTER port map (Y, SIGN_Y, temp_exp_y, mantix_y);

  MANTIX_FIXER_X: MANTIX_FIXER port map (mantix_x, temp_exp_x, fixed_mantix_x_temp);
  MANTIX_FIXER_Y: MANTIX_FIXER port map (mantix_y, temp_exp_y, fixed_mantix_y_temp);

  compute: process (temp_exp_x, temp_exp_y, SIGN_X, SIGN_Y , fixed_mantix_x_temp, fixed_mantix_y_temp)
  begin

  fixed_mantix_x <= fixed_mantix_x_temp;
  fixed_mantix_y <= fixed_mantix_y_temp;
  exp_x <= temp_exp_x;
  exp_y <= temp_exp_y;
  sign <= SIGN_X xor SIGN_Y;
  end process;

  EDGE_CASES: EDGE_CASES_HANDLER port map (X, Y, zero, invalid, inf, both_denorm);

end architecture;


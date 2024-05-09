
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity SECOND_STAGE is
  port (
    CLK, RST                                        : in  std_logic;
    exp_x, exp_y                                    : in  std_logic_vector(7 downto 0);
    mantix_x, mantix_y                              : in  std_logic_vector(23 downto 0);
    sign_in                                         : in  std_logic;
    zero_in, invalid_in, inf_in, both_denorm_in     : in  std_logic;
    sign_out                                        : out std_logic;
    zero_out, invalid_out, inf_out, both_denorm_out : out std_logic;
    intermediate_exp                                : out std_logic_vector(9 downto 0);
    intermediate_mantix                             : out std_logic_vector(47 downto 0)
  );
end entity;

architecture RTL of SECOND_STAGE is
  component REG_PP_1 is
    port (
      CLK : in  std_logic;
      RST : in  std_logic;
      X   : in  std_logic;
      Y   : out std_logic
    );
  end component;

  component REG_PP_N is
    generic (
      N : integer
    );
    port (
      CLK : in  std_logic;
      RST : in  std_logic;
      X   : in  std_logic_vector(N - 1 downto 0);
      Y   : out std_logic_vector(N - 1 downto 0)
    );
  end component;

  component EXP_ADDER is
    port (
      E1  : in  STD_LOGIC_VECTOR(7 downto 0);
      E2  : in  STD_LOGIC_VECTOR(7 downto 0);
      SUM : out STD_LOGIC_VECTOR(8 downto 0)
    );
  end component;

  component BIAS_SUBTRACTOR is
    port (
      EXP  : in  STD_LOGIC_VECTOR(8 downto 0);
      BIAS : in  STD_LOGIC_VECTOR(8 downto 0);
      S    : out STD_LOGIC_VECTOR(9 downto 0)
    );
  end component;

  component MUL_24_CLA is
    port (
      X : in  std_logic_vector(23 downto 0);
      Y : in  std_logic_vector(23 downto 0);
      P : out std_logic_vector(47 downto 0)
    );
  end component;

  signal REGOUT_EXP_X, REGOUT_EXP_Y       : std_logic_vector(7 downto 0);
  signal REGOUT_MANTIX_X, REGOUT_MANTIX_Y : std_logic_vector(23 downto 0);

  constant BIAS : std_logic_vector(8 downto 0) := "001111111";
  signal exponents_sum : std_logic_vector(8 downto 0);

begin
  REG_EXP_X: REG_PP_N generic map (8) port map (CLK, RST, exp_x, REGOUT_EXP_X);
  REG_EXP_Y: REG_PP_N generic map (8) port map (CLK, RST, exp_y, REGOUT_EXP_Y);
  REG_MANTIX_X: REG_PP_N generic map (24) port map (CLK, RST, mantix_x, REGOUT_MANTIX_X);
  REG_MANTIX_Y: REG_PP_N generic map (24) port map (CLK, RST, mantix_y, REGOUT_MANTIX_Y);

  REG_SIGN: REG_PP_1 port map (CLK, RST, sign_in, sign_out);
  REG_ZERO: REG_PP_1 port map (CLK, RST, zero_in, zero_out);
  REG_INVALID: REG_PP_1 port map (CLK, RST, invalid_in, invalid_out);
  REG_INF: REG_PP_1 port map (CLK, RST, inf_in, inf_out);
  REG_BOTH_DENORM: REG_PP_1 port map (CLK, RST, both_denorm_in, both_denorm_out);

  MANTIX_MULT: MUL_24_CLA port map (REGOUT_MANTIX_X, REGOUT_MANTIX_Y, intermediate_mantix);

  EXP_ADD: EXP_ADDER port map (REGOUT_EXP_X, REGOUT_EXP_Y, exponents_sum);

  BIAS_SUB: BIAS_SUBTRACTOR port map (exponents_sum, BIAS, intermediate_exp);

end architecture;



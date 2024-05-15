
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity PIPELINED_MULT is
  port (
    X              : in  STD_LOGIC_VECTOR(31 downto 0);
    Y              : in  STD_LOGIC_VECTOR(31 downto 0);
    CLK            : in  STD_LOGIC;
    RST            : in  STD_LOGIC;
    P              : out STD_LOGIC_VECTOR(31 downto 0);
    invalid_output : out STD_LOGIC
  );
end entity;

architecture structural of PIPELINED_MULT is
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
      N : integer := 32
    );
    port (
      CLK : in  std_logic;
      RST : in  std_logic;
      X   : in  std_logic_vector(N - 1 downto 0);
      Y   : out std_logic_vector(N - 1 downto 0)
    );
  end component;

  component FIRST_STAGE is
    port (
      CLK, RST                        : in  std_logic;
      X, Y                            : in  std_logic_vector(31 downto 0);
      zero, invalid, inf, both_denorm : out std_logic;
      sign                            : out std_logic;
      exp_x, exp_y                    : out std_logic_vector(7 downto 0);
      fixed_mantix_x, fixed_mantix_y  : out std_logic_vector(23 downto 0)
    );
  end component;

  component SECOND_STAGE is
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
  end component;

  component THIRD_STAGE is
    port (
      CLK, RST                        : in  std_logic;
      sign                            : in  std_logic;
      zero, invalid, inf, both_denorm : in  std_logic;
      intermediate_exp                : in  std_logic_vector(9 downto 0);
      intermediate_mantix             : in  std_logic_vector(47 downto 0);
      invalid_out                     : out std_logic;
      result_out                      : out std_logic_vector(31 downto 0)
    );
  end component;

  component REG_PP_32 is
    port (
      CLK : in  std_logic;
      RST : in  std_logic;
      X   : in  std_logic_vector(31 downto 0);
      Y   : out std_logic_vector(31 downto 0)
    );
  end component;

  signal REGOUT_X, REGOUT_Y                                                  : std_logic_vector(31 downto 0);
  signal zero_1_out, invalid_1_out, inf_1_out, both_denorm_1_out, sign_1_out : std_logic;
  signal sign_2_out, zero_2_out, invalid_2_out, inf_2_out, both_denorm_2_out : std_logic;
  signal exp_x, exp_y                                                        : std_logic_vector(7 downto 0);
  signal mantix_x, mantix_y                                                  : std_logic_vector(23 downto 0);
  signal intermediate_exp                                                    : std_logic_vector(9 downto 0);
  signal intermediate_mantix                                                 : std_logic_vector(47 downto 0);
  signal temp_p                                                              : std_logic_vector(31 downto 0);
  signal temp_invalid                                                        : std_logic;

begin


FIRST: FIRST_STAGE port map (
  CLK => CLK,
  RST => RST,
  X => REGOUT_X,
  Y => REGOUT_Y,
  zero => zero_1_out,
  invalid => invalid_1_out,
  inf => inf_1_out,
  both_denorm => both_denorm_1_out,
  sign => sign_1_out,
  exp_x => exp_x,
  exp_y => exp_y,
  fixed_mantix_x => mantix_x,
  fixed_mantix_y => mantix_y
);

  SECOND: SECOND_STAGE port map (
    CLK => CLK,
    RST => RST,
    exp_x => exp_x,
    exp_y => exp_y,
    mantix_x => mantix_x,
    mantix_y => mantix_y,
    sign_in => sign_1_out,
    zero_in => zero_1_out,
    invalid_in => invalid_1_out,
    inf_in => inf_1_out,
    both_denorm_in => both_denorm_1_out,
    sign_out => sign_2_out,
    zero_out => zero_2_out,
    invalid_out => invalid_2_out,
    inf_out => inf_2_out,
    both_denorm_out => both_denorm_2_out,
    intermediate_exp => intermediate_exp,
    intermediate_mantix => intermediate_mantix
  );

  THIRD: THIRD_STAGE port map (
    CLK => CLK,
    RST => RST,
    sign => sign_2_out,
    zero => zero_2_out,
    invalid => invalid_2_out,
    inf => inf_2_out,
    both_denorm => both_denorm_2_out,
    intermediate_exp => intermediate_exp,
    intermediate_mantix => intermediate_mantix,
    invalid_out => temp_invalid,
    result_out => temp_p
  );


  REG_X_IN: REG_PP_N generic map (32) port map (CLK, RST, X, REGOUT_X);
  REG_Y_IN: REG_PP_N generic map (32) port map (CLK, RST, Y, REGOUT_Y);

  REG_P_OUT: REG_PP_32 port map (CLK, RST, temp_p, P);
  REG_P_INVALID_OUT: REG_PP_1 port map (CLK, RST, temp_invalid, invalid_output);

  
end architecture;


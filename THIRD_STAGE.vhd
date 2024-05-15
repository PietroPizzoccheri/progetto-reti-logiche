
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity THIRD_STAGE is
  port (
    CLK, RST                        : in  std_logic;
    sign                            : in  std_logic;
    zero, invalid, inf, both_denorm : in  std_logic;
    intermediate_exp                : in  std_logic_vector(9 downto 0);
    intermediate_mantix             : in  std_logic_vector(47 downto 0);
    invalid_out                     : out std_logic;
    result_out                      : out std_logic_vector(31 downto 0)
  );
end entity;

architecture RTL of THIRD_STAGE is
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
      result_in   : in  std_logic_vector(31 downto 0);
      zero        : in  std_logic;
      invalid_in  : in  std_logic;
      inf         : in  std_logic;
      both_denorm : in  std_logic;
      result_out  : out std_logic_vector(31 downto 0);
      invalid_out : out std_logic
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

  signal REGOUT_INTERMEDIATE_EXP                                                  : std_logic_vector(9 downto 0);
  signal REGOUT_INTERMEDIATE_MANTIX                                               : std_logic_vector(47 downto 0);
  signal REGOUT_SIGN, REGOUT_ZERO, REGOUT_INVALID, REGOUT_INF, REGOUT_BOTH_DENORM : std_logic;

  signal ROUNDED_MANTIX : std_logic_vector(22 downto 0);
  signal ROUNDER_OFFSET : std_logic_vector(4 downto 0);
  signal ROUNDER_SUB    : std_logic;

  signal ROUNDED_EXP : std_logic_vector(9 downto 0);

  signal FIXED_EXP    : std_logic_vector(7 downto 0);
  signal FIXED_MANTIX : std_logic_vector(22 downto 0);

  signal TEMP_RESULT : std_logic_vector(31 downto 0);

  signal result_out_sig : std_logic_vector(31 downto 0);
  signal invalid_out_sig : std_logic;
begin
  REG_INTERMEDIATE_EXP: REG_PP_N generic map (10) port map (CLK, RST, intermediate_exp, REGOUT_INTERMEDIATE_EXP);
  REG_INTERMEDIATE_MANTIX: REG_PP_N generic map (48) port map (CLK, RST, intermediate_mantix, REGOUT_INTERMEDIATE_MANTIX);

  REG_SIGN: REG_PP_1 port map (CLK, RST, sign, REGOUT_SIGN);

  REG_ZERO: REG_PP_1 port map (CLK, RST, zero, REGOUT_ZERO);
  REG_INVALID: REG_PP_1 port map (CLK, RST, invalid, REGOUT_INVALID);
  REG_INF: REG_PP_1 port map (CLK, RST, inf, REGOUT_INF);
  REG_BOTH_DENORM: REG_PP_1 port map (CLK, RST, both_denorm, REGOUT_BOTH_DENORM);

  ROUND: ROUNDER port map (REGOUT_INTERMEDIATE_MANTIX, ROUNDED_MANTIX, ROUNDER_OFFSET, ROUNDER_SUB);

  EXP_CALC: FINAL_EXP_CALCULATOR port map (REGOUT_INTERMEDIATE_EXP, ROUNDER_OFFSET, ROUNDER_SUB, ROUNDED_EXP);

  FIX_RESULT: RESULT_FIXER port map (ROUNDED_EXP, ROUNDED_MANTIX, FIXED_EXP, FIXED_MANTIX);

  TEMP_RESULT <= (REGOUT_SIGN & FIXED_EXP & FIXED_MANTIX);

  compute: process (result_out_sig,invalid_out_sig)
  begin
    result_out<= result_out_sig;
    invalid_out<= invalid_out_sig;
  end process;
  

  outp: OUTPUT_LOGIC
    port map (
      result_in   => TEMP_RESULT,
      zero        => REGOUT_ZERO,
      invalid_in  => REGOUT_INVALID,
      inf         => REGOUT_INF,
      both_denorm => REGOUT_BOTH_DENORM,
      result_out  => result_out_sig,
      invalid_out => invalid_out_sig
    );

end architecture;



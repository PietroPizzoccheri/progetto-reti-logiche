
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity SECOND_STAGE is
  port (
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

  component MUL_24_CLA_SPLITTED is
    port (
      X : in  std_logic_vector(23 downto 0);
      Y : in  std_logic_vector(23 downto 0);
      P : out std_logic_vector(47 downto 0)
    );
  end component;

  --signal REGOUT_EXP_X, REGOUT_EXP_Y       : std_logic_vector(7 downto 0);
  --signal REGOUT_MANTIX_X, REGOUT_MANTIX_Y : std_logic_vector(23 downto 0);
  signal intermediate_exp_signal          : std_logic_vector(9 downto 0);
  signal intermediate_mantix_signal       : std_logic_vector(47 downto 0);
  --signal zero_out_signal, invalid_out_signal, inf_out_signal, both_denorm_out_signal,sign_out_signal: std_logic;

  constant BIAS : std_logic_vector(8 downto 0) := "001111111";
  signal exponents_sum : std_logic_vector(8 downto 0);

begin

  MANTIX_MULT: MUL_24_CLA_SPLITTED port map (mantix_x, mantix_y, intermediate_mantix_signal);

  EXP_ADD: EXP_ADDER port map (exp_x, exp_y, exponents_sum);

  BIAS_SUB: BIAS_SUBTRACTOR port map (exponents_sum, BIAS, intermediate_exp_signal);

  
  invalid_out <= invalid_in;
  zero_out <= zero_in;
  inf_out <= inf_in;
  sign_out <= sign_in;
  both_denorm_out <= both_denorm_in;
  intermediate_exp <= intermediate_exp_signal;
  intermediate_mantix <= intermediate_mantix_signal;
  
  


end architecture;



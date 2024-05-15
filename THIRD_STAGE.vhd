
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity THIRD_STAGE is
  port (
    sign                            : in  std_logic;
    zero, invalid, inf, both_denorm : in  std_logic;
    intermediate_exp                : in  std_logic_vector(9 downto 0);
    intermediate_mantix             : in  std_logic_vector(47 downto 0);
    invalid_out                     : out std_logic;
    result_out                      : out std_logic_vector(31 downto 0)
  );
end entity;

architecture RTL of THIRD_STAGE is

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

  signal ROUNDED_MANTIX : std_logic_vector(22 downto 0);
  signal ROUNDER_OFFSET : std_logic_vector(4 downto 0);
  signal ROUNDER_SUB    : std_logic;

  signal ROUNDED_EXP : std_logic_vector(9 downto 0);

  signal FIXED_EXP    : std_logic_vector(7 downto 0);
  signal FIXED_MANTIX : std_logic_vector(22 downto 0);

  signal TEMP_RESULT : std_logic_vector(31 downto 0);

  signal result_out_sig  : std_logic_vector(31 downto 0);
  signal invalid_out_sig : std_logic;
begin

  outp: OUTPUT_LOGIC
    port map (
      result_in   => TEMP_RESULT,
      zero        => zero,
      invalid_in  => invalid,
      inf         => inf,
      both_denorm => both_denorm,
      result_out  => result_out_sig,
      invalid_out => invalid_out_sig
    );

  ROUND: ROUNDER port map (intermediate_mantix, ROUNDED_MANTIX, ROUNDER_OFFSET, ROUNDER_SUB);

  EXP_CALC: FINAL_EXP_CALCULATOR port map (intermediate_exp, ROUNDER_OFFSET, ROUNDER_SUB, ROUNDED_EXP);

  FIX_RESULT: RESULT_FIXER port map (ROUNDED_EXP, ROUNDED_MANTIX, FIXED_EXP, FIXED_MANTIX);

  TEMP_RESULT <= (sign & FIXED_EXP & FIXED_MANTIX);
  result_out  <= result_out_sig;
  invalid_out <= invalid_out_sig;

  

end architecture;



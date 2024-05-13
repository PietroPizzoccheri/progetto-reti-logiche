
library ieee;
  use ieee.std_logic_1164.all;

entity TB_RESULT_FIXER is
end entity;

architecture behavior of TB_RESULT_FIXER is

  -- Component Declaration for the Unit Under Test (UUT)
  component RESULT_FIXER
    port (
      INTERMEDIATE_EXP    : in  std_logic_vector(9 downto 0);
      INTERMEDIATE_MANTIX : in  std_logic_vector(22 downto 0);
      EXP                 : out std_logic_vector(7 downto 0);
      MANTIX              : out std_logic_vector(22 downto 0)
    );
  end component;

  --Inputs
  signal INTERMEDIATE_EXP    : std_logic_vector(9 downto 0)  := (others => '0');
  signal INTERMEDIATE_MANTIX : std_logic_vector(22 downto 0) := (others => '0');

  --Outputs
  signal EXP    : std_logic_vector(7 downto 0);
  signal MANTIX : std_logic_vector(22 downto 0);
  -- No clocks detected in port list. Replace <clock> below with 
  -- appropriate port name 
  -- expected outputs
  signal expected_EXP    : std_logic_vector(7 downto 0);
  signal expected_MANTIX : std_logic_vector(22 downto 0);

begin

  -- Instantiate the Unit Under Test (UUT)
  uut: RESULT_FIXER
    port map (
      INTERMEDIATE_EXP    => INTERMEDIATE_EXP,
      INTERMEDIATE_MANTIX => INTERMEDIATE_MANTIX,
      EXP                 => EXP,
      MANTIX              => MANTIX
    );

  -- Stimulus process

  stim_proc: process
  begin

    -- hold reset state for 100 ns.
    wait for 50 ns;

    --underflow expected
    INTERMEDIATE_EXP <= "1111101001";
    INTERMEDIATE_MANTIX <= "11100000000000000000000";
    expected_EXP <= "00000000";
    expected_MANTIX <= "00000000000000000000000";
    wait for 50 ns;
    assert (EXP = expected_EXP and MANTIX = expected_MANTIX) report "Test 1 failed" severity error;

    --denormalized expected
    INTERMEDIATE_EXP <= "1111101111";
    INTERMEDIATE_MANTIX <= "11100000000000000000000";
    expected_EXP <= "00000000";
    expected_MANTIX <= "00000000000000001111000";
    wait for 50 ns;
    assert (EXP = expected_EXP and MANTIX = expected_MANTIX) report "Test 2 failed" severity error;

    --overflow case
    INTERMEDIATE_EXP <= "0111101111";
    INTERMEDIATE_MANTIX <= "00000000000111000000000";
    expected_EXP <= "11111111";
    expected_MANTIX <= "00000000000000000000000";
    wait for 50 ns;
    assert (EXP = expected_EXP and MANTIX = expected_MANTIX) report "Test 3 failed" severity error;

    --ok case
    INTERMEDIATE_EXP <= "0011101111";
    INTERMEDIATE_MANTIX <= "00000000000111000000000";
    expected_EXP <= "11101111";
    expected_MANTIX <= "00000000000111000000000";
    wait for 50 ns;
    assert (EXP = expected_EXP and MANTIX = expected_MANTIX) report "Test 4 failed" severity error;

    wait;
  end process;

end architecture;

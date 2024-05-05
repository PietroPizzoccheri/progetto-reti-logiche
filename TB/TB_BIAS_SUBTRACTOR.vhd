library ieee;
  use ieee.std_logic_1164.all;

entity TB_BIAS_SUBTRACTOR is
end entity;

architecture behavior of TB_BIAS_SUBTRACTOR is

  -- Component Declaration for the Unit Under Test (UUT)
  -- Testing for CLA with 5 bits
  component BIAS_SUBTRACTOR
    port (
      EXP  : in  STD_LOGIC_VECTOR(8 downto 0);
      BIAS : in  STD_LOGIC_VECTOR(8 downto 0);
      S    : out STD_LOGIC_VECTOR(9 downto 0)
    );
  end component;

  --Inputs
  signal EXP  : std_logic_vector(8 downto 0) := (others => '0');
  signal BIAS : std_logic_vector(8 downto 0) := (others => '0');

  --Outputs
  signal S          : std_logic_vector(9 downto 0);
  signal EXPECTED_S : std_logic_vector(9 downto 0);

  --Utility
  constant MAXIMUM_BIAS : std_logic_vector(8 downto 0) := "010010110";
begin

  -- Instantiate the Unit Under Test (UUT)
  uut: BIAS_SUBTRACTOR
    port map (
      EXP  => EXP,
      BIAS => BIAS,
      S    => S
    );

  -- Stimulus process
  process
  begin
    -- Maximum value for EXP and BIAS
    EXP <= "111111110";
    BIAS <= MAXIMUM_BIAS;
    EXPECTED_S <= "1101101000";
    wait for 50 ns;
    assert S = EXPECTED_S
      severity error;

    -- Minimum value for EXP and Maximum BIAS
    EXP <= "000000001";
    BIAS <= MAXIMUM_BIAS;
    EXPECTED_S <= "1101101011";
    wait for 50 ns;
    assert S = EXPECTED_S
      severity error;

    EXP <= "100000101";
    BIAS <= "001111111";
    EXPECTED_S <= "11010000110";
    wait for 50 ns;
    assert S = EXPECTED_S
      severity error;

    wait;

  end process;
end architecture;

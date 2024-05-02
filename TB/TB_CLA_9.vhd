library ieee;
  use ieee.std_logic_1164.all;

entity TB_CLA_9 is
end entity;

architecture behavior of TB_CLA_9 is

  -- Component Declaration for the Unit Under Test (UUT)
  -- Testing for CLA with 5 bits
  component BIAS_SUBTRACTOR
    port (
      EXP  : in  STD_LOGIC_VECTOR(8 downto 0);
      BIAS : in  STD_LOGIC_VECTOR(8 downto 0);
      S    : out STD_LOGIC_VECTOR(8 downto 0)
    );
  end component;

  component CLA_9 is
    port (
      X, Y : in  std_logic_vector(9 - 1 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(9 - 1 downto 0);
      Cout : out std_logic
    );
  end component;

  --Inputs
  signal EXP  : std_logic_vector(8 downto 0) := (others => '0');
  signal BIAS : std_logic_vector(8 downto 0) := (others => '0');

  --Outputs
  signal S          : std_logic_vector(9 downto 0);
  signal EXPECTED_S : std_logic_vector(9 downto 0);
begin

  -- Instantiate the Unit Under Test (UUT)
  --   uut: BIAS_SUBTRACTOR
  --     port map (
  --       EXP  => EXP,
  --       BIAS => BIAS,
  --       S    => S
  --     );
  -- Stimulus process
  uut: CLA_9
    port map (
      X    => EXP,
      Y    => BIAS,
      S    => S(8 downto 0),
      Cin  => '0',
      Cout => S(9)
    );

  process
  begin
    -- EXP <= "000000100";
    -- BIAS <= "000000100";
    -- EXPECTED_S <= "000000010";
    -- wait for 20 ns;
    -- assert S = EXPECTED_S
    --   severity error;
    EXP <= "000000100";
    BIAS <= "111111011";

    wait for 20 ns;

    EXP <= "001100100";
    BIAS <= "111111011";

    wait for 20 ns;

    EXP <= "000000110";
    BIAS <= "111111011";

    wait for 20 ns;

    EXP <= "000000100";
    BIAS <= "110011011";

    wait for 20 ns;

    EXP <= "000000101";
    BIAS <= "111111001";

    wait for 20 ns;

    EXP <= "000000100";
    BIAS <= "111011011";

    wait for 20 ns;

    EXP <= "000000100";
    BIAS <= "111111011";

    wait for 20 ns;

    wait;

  end process;

end architecture;

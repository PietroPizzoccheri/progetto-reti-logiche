library ieee;
  use ieee.std_logic_1164.all;

entity TB_CLA_N is
end entity;

architecture behavior of TB_CLA_N is

  -- Component Declaration for the Unit Under Test (UUT)
  -- Testing for CLA with 5 bits
  component CLA_N
    generic (
      N : integer
    );
    port (
      X    : in  std_logic_vector(N - 1 downto 0);
      Y    : in  std_logic_vector(N - 1 downto 0);
      S    : out std_logic_vector(N - 1 downto 0);
      Cin  : in  std_logic;
      Cout : out std_logic
    );
  end component;

  --Inputs
  signal X   : std_logic_vector(4 downto 0) := (others => '0');
  signal Y   : std_logic_vector(4 downto 0) := (others => '0');
  signal Cin : std_logic                    := '0';

  --Outputs
  signal S    : std_logic_vector(4 downto 0);
  signal Cout : std_logic;

  signal EXPECTED_S    : std_logic_vector(4 downto 0);
  signal EXPECTED_COUT : std_logic;
begin

  -- Instantiate the Unit Under Test (UUT)
  uut: CLA_N
    generic map (
      N => 5
    )
    port map (
      X    => X,
      Y    => Y,
      S    => S,
      Cin  => Cin,
      Cout => Cout
    );

  -- Stimulus process
  process
  begin
    X <= "00000";
    Y <= "00000";
    Cin <= '0';

    EXPECTED_S <= "00000";
    EXPECTED_COUT <= '0';
    wait for 100 ns;

    assert S = EXPECTED_S
      severity error;

    assert COUT = EXPECTED_COUT
      severity error;

    -- Cin is used correctly
    X <= "00000";
    Y <= "00000";
    Cin <= '1';

    EXPECTED_S <= "00001";
    EXPECTED_COUT <= '0';
    wait for 100 ns;

    assert S = EXPECTED_S
      severity error;

    assert COUT = EXPECTED_COUT
      severity error;

    -- Sum works correctly
    X <= "00001";
    Y <= "00001";
    Cin <= '0';

    EXPECTED_S <= "00010";
    EXPECTED_COUT <= '0';
    wait for 100 ns;

    assert S = EXPECTED_S
      severity error;

    assert COUT = EXPECTED_COUT
      severity error;

    -- Another Sum
    X <= "01000";
    Y <= "01100";
    Cin <= '0';

    EXPECTED_S <= "10100";
    EXPECTED_COUT <= '0';
    wait for 100 ns;

    assert S = EXPECTED_S
      severity error;

    assert COUT = EXPECTED_COUT
      severity error;

    -- Max value works
    X <= "11111";
    Y <= "11111";
    Cin <= '1';

    EXPECTED_S <= "11111";
    EXPECTED_COUT <= '1';

    wait for 100 ns;

    assert S = EXPECTED_S
      severity error;

    assert COUT = EXPECTED_COUT
      severity error;

    wait;

  end process;

end architecture;

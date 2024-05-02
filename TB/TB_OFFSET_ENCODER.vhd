library ieee;
  use ieee.std_logic_1164.all;

entity TB_OFFSET_ENCODER is
end entity;

architecture behavior of TB_OFFSET_ENCODER is

  -- Component Declaration for the Unit Under Test (UUT)
  component OFFSET_ENCODER
    port (
      X : in  std_logic_vector(22 downto 0);
      Y : out std_logic_vector(4 downto 0);
      Z : out std_logic
    );
  end component;

  --Inputs
  signal X : std_logic_vector(22 downto 0) := (others => '0');

  --Outputs
  signal Y : std_logic_vector(4 downto 0);
  signal Z : std_logic;

  signal EXPECTED_Y : std_logic_vector(4 downto 0);
  signal EXPECTED_Z : std_logic;

begin
  -- Instantiate the Unit Under Test (UUT)
  uut: OFFSET_ENCODER
    port map (
      X => X,
      Y => Y,
      Z => Z
    );

  -- Stimulus process

  stim_proc: process
  begin
    -- Edge Case
    X <= "00000000000000000000000";
    EXPECTED_Y <= "-----";
    EXPECTED_Z <= '1';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Edge Case failed" severity error;
    assert (Z = EXPECTED_Z) report "Edge Case failed" severity error;

    X <= "10000000000000000000000";
    EXPECTED_Y <= "00001";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 1 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 1 failed" severity error;

    X <= "00000000000000000000001";
    EXPECTED_Y <= "10111";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 2 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 2 failed" severity error;

    X <= "00000000000100000000000";
    EXPECTED_Y <= "01100";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 3 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 3 failed" severity error;

    X <= "00000000000100001010000";
    EXPECTED_Y <= "01100";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 4 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 4 failed" severity error;

    wait;
  end process;

end architecture;

library ieee;
  use ieee.std_logic_1164.all;

entity TB_OFFSET_ENCODER is
end entity;

architecture behavior of TB_OFFSET_ENCODER is

  -- Component Declaration for the Unit Under Test (UUT)
  component OFFSET_ENCODER
    port (
      X : in  std_logic_vector(23 downto 0);
      Y : out std_logic_vector(4 downto 0);
      Z : out std_logic
    );
  end component;

  --Inputs
  signal X : std_logic_vector(23 downto 0) := (others => '0');

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
    X <= "000000000000000000000000";
    EXPECTED_Y <= "-----";
    EXPECTED_Z <= '1';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Edge Case failed" severity error;
    assert (Z = EXPECTED_Z) report "Edge Case failed" severity error;

    X <= "100000000000000000000000";
    EXPECTED_Y <= "00001";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 1 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 1 failed" severity error;

    X <= "000000000000000000000001";
    EXPECTED_Y <= "11000";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 2 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 2 failed" severity error;

    X <= "000000000000000000000010";
    EXPECTED_Y <= "10111";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 3 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 3 failed" severity error;

    X <= "000000000000000000000100";
    EXPECTED_Y <= "10110";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 4 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 4 failed" severity error;

    X <= "000000000000000000001000";
    EXPECTED_Y <= "10101";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 5 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 5 failed" severity error;

    X <= "000000000000000000010000";
    EXPECTED_Y <= "10100";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 6 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 6 failed" severity error;

    X <= "000000000000000000100000";
    EXPECTED_Y <= "10011";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 7 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 7 failed" severity error;

    X <= "000000000000000001000000";
    EXPECTED_Y <= "10010";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 8 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 8 failed" severity error;

    X <= "000000000000000010000000";
    EXPECTED_Y <= "10001";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 9 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 9 failed" severity error;

    X <= "000000000000000100000000";
    EXPECTED_Y <= "10000";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 10 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 10 failed" severity error;

    X <= "000000000000001000000000";
    EXPECTED_Y <= "01111";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 11 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 11 failed" severity error;

    X <= "000000000000010000000000";
    EXPECTED_Y <= "01110";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 12 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 12 failed" severity error;

    X <= "000000000000100000000000";
    EXPECTED_Y <= "01101";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 13 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 13 failed" severity error;

    X <= "000000000001000000000000";
    EXPECTED_Y <= "01110";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 14 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 14 failed" severity error;

    X <= "000000000010000000000000";
    EXPECTED_Y <= "01111";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 15 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 15 failed" severity error;

    X <= "000000000100000000000000";
    EXPECTED_Y <= "10000";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 16 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 16 failed" severity error;

    X <= "000000001000000000000000";
    EXPECTED_Y <= "01111";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 17 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 17 failed" severity error;

    X <= "000000010000000000000000";
    EXPECTED_Y <= "01110";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 18 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 18 failed" severity error;

    X <= "000000100000000000000000";
    EXPECTED_Y <= "01101";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 19 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 19 failed" severity error;







    X <= "000000000000100000000000";
    EXPECTED_Y <= "01101";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 20 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 20 failed" severity error;

    X <= "000000000000100001010000";
    EXPECTED_Y <= "01101";
    EXPECTED_Z <= '0';
    wait for 50 ns;
    assert (Y = EXPECTED_Y) report "Test 21 failed" severity error;
    assert (Z = EXPECTED_Z) report "Test 21 failed" severity error;

    wait;
  end process;

end architecture;

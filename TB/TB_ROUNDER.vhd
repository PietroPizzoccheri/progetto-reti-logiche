library ieee;
  use ieee.std_logic_1164.all;

entity TB_ROUNDER is
end entity;

architecture behavior of TB_ROUNDER is
  component ROUNDER
    port (
      MANTIX  : in  std_logic_vector(47 downto 0);
      SHIFTED : out std_logic_vector(22 downto 0);
      OFFSET  : out std_logic_vector(4 downto 0);
      SUB     : out std_logic
    );
  end component;

  --Inputs
  signal MANTIX : std_logic_vector(47 downto 0);

  --Outputs
  signal SHIFTED : std_logic_vector(22 downto 0);
  signal OFFSET  : std_logic_vector(4 downto 0);
  signal SUB     : std_logic;

  -- Utility signals
  signal EXPECTED_SHIFTED : std_logic_vector(22 downto 0);
  signal EXPECTED_OFFSET  : std_logic_vector(4 downto 0);
  signal EXPECTED_SUB     : std_logic;
begin

  -- Instantiate the Unit Under Test (UUT)
  uut: ROUNDER
    port map (
      MANTIX  => MANTIX,
      SHIFTED => SHIFTED,
      OFFSET  => OFFSET,
      SUB     => SUB
    );

  -- Stimulus process

  stim_proc: process
  begin
    -- hold reset state for 100 ns.
    wait for 100 ns;

    -- Test 1
    MANTIX <= "110010000000000000000000000000000000000000000000";
    EXPECTED_SHIFTED <= "10010000000000000000000";
    EXPECTED_OFFSET <= "00001";
    EXPECTED_SUB <= '0';

    wait for 50 ns;
    assert (SHIFTED = EXPECTED_SHIFTED) report "Test 1 failed" severity error;
    assert (OFFSET = EXPECTED_OFFSET) report "Test 1 failed" severity error;
    assert (SUB = EXPECTED_SUB) report "Test 1 failed" severity error;

    -- Test 2
    MANTIX <= "011001000000000000000000000000000000000000000000";
    EXPECTED_SHIFTED <= "10010000000000000000000";
    EXPECTED_OFFSET <= "00000";
    EXPECTED_SUB <= '0';

    wait for 50 ns;
    assert (SHIFTED = EXPECTED_SHIFTED) report "Test 2 failed" severity error;
    assert (OFFSET = EXPECTED_OFFSET) report "Test 2 failed" severity error;
    assert (SUB = EXPECTED_SUB) report "Test 2 failed" severity error;

    -- Test 3
    MANTIX <= "001100100000000000000000000000000000000000000000";
    EXPECTED_SHIFTED <= "10010000000000000000000";
    EXPECTED_OFFSET <= "00001";
    EXPECTED_SUB <= '1';

    wait for 50 ns;
    assert (SHIFTED = EXPECTED_SHIFTED) report "Test 3 failed" severity error;
    assert (OFFSET = EXPECTED_OFFSET) report "Test 3 failed" severity error;
    assert (SUB = EXPECTED_SUB) report "Test 3 failed" severity error;

    -- Test 4
    MANTIX <= "000000000000000010000000100000000000000000000000";
    EXPECTED_SHIFTED <= "00000001000000000000000";
    EXPECTED_OFFSET <= "01111";
    EXPECTED_SUB <= '1';

    wait for 50 ns;
    assert (SHIFTED = EXPECTED_SHIFTED) report "Test 4 failed" severity error;
    assert (OFFSET = EXPECTED_OFFSET) report "Test 4 failed" severity error;
    assert (SUB = EXPECTED_SUB) report "Test 4 failed" severity error;

    -- Test 5
    MANTIX <= "000000000000000000000000010000000000000000000001";
    EXPECTED_SHIFTED <= "00000000000000000000010";
    EXPECTED_OFFSET <= "11000";
    EXPECTED_SUB <= '1';

    wait for 50 ns;
    assert (SHIFTED = EXPECTED_SHIFTED) report "Test 5 failed" severity error;
    assert (OFFSET = EXPECTED_OFFSET) report "Test 5 failed" severity error;
    assert (SUB = EXPECTED_SUB) report "Test 5 failed" severity error;

    wait;
  end process;

end architecture;

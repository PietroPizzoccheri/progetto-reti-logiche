library ieee;
  use ieee.std_logic_1164.all;

entity TB_MANTIX_FIXER is
end entity;

architecture behavior of TB_MANTIX_FIXER is

  -- Component Declaration for the Unit Under Test (UUT)
  component MANTIX_FIXER
    port (
      MANTIX     : in  std_logic_vector(22 downto 0);
      exp        : in  std_logic_vector(7 downto 0);
      MANTIX_OUT : out std_logic_vector(23 downto 0);
      OFFSET     : out std_logic_vector(4 downto 0)
    );
  end component;

  --Inputs
  signal MANTIX : std_logic_vector(22 downto 0) := (others => '0');
  signal exp    : std_logic_vector(7 downto 0)  := (others => '0');

  --Outputs
  signal MANTIX_OUT : std_logic_vector(23 downto 0);
  signal OFFSET     : std_logic_vector(4 downto 0);

  -- Utility signals
  signal EXPECTED_MANTIX_OUT : std_logic_vector(23 downto 0);
  signal EXPECTED_OFFSET     : std_logic_vector(4 downto 0);
begin

  -- Instantiate the Unit Under Test (UUT)
  uut: MANTIX_FIXER
    port map (
      MANTIX     => MANTIX,
      exp        => exp,
      MANTIX_OUT => MANTIX_OUT,
      OFFSET     => OFFSET
    );

  -- Stimulus process

  stim_proc: process
  begin
    -- hold reset state for 100 ns.
    wait for 100 ns;

    -- Test 1
    exp <= "00000000";
    MANTIX <= "01100000000000000000000";

    EXPECTED_MANTIX_OUT <= "100000000000000000000000";
    EXPECTED_OFFSET <= "00011";
    wait for 50 ns;
    assert (MANTIX_OUT = EXPECTED_MANTIX_OUT and OFFSET = EXPECTED_OFFSET) report "Test 1 failed" severity error;

    -- Test 2
    exp <= "00000001";
    MANTIX <= "01100000000000000000000";

    EXPECTED_MANTIX_OUT <= "101100000000000000000000";
    EXPECTED_OFFSET <= "00000";
    wait for 50 ns;
    assert (MANTIX_OUT = EXPECTED_MANTIX_OUT and OFFSET = EXPECTED_OFFSET) report "Test 2 failed" severity error;
    wait;
  end process;

end architecture;

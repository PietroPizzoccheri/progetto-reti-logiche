library ieee;
  use ieee.std_logic_1164.all;

entity TB_OUTPUT_LOGIC is
end entity;

architecture behavior of TB_OUTPUT_LOGIC is

  component OUTPUT_LOGIC
    port (
      result_in          : in  std_logic_vector(31 downto 0);
      zero               : in  std_logic;
      invalid_in         : in  std_logic;
      inf                : in  std_logic;
      overflow_underflow : in  std_logic;
      result_out         : out std_logic_vector(31 downto 0);
      invalid_out        : out std_logic
    );
  end component;

  --Inputs
  signal result_in          : std_logic_vector(31 downto 0) := (others => '0');
  signal zero               : std_logic                     := '0';
  signal invalid_in         : std_logic                     := '0';
  signal inf                : std_logic                     := '0';
  signal overflow_underflow : std_logic                     := '0';

  --Outputs
  signal result_out  : std_logic_vector(31 downto 0);
  signal invalid_out : std_logic;

  --Constants
  constant MOCK_RESULT : std_logic_vector(31 downto 0) := "10011101011010001010110101010101";

  --Utility signals
  signal EXPECTED_INVALID : std_logic;
  signal EXPECTED_RESULT  : std_logic_vector(31 downto 0);
begin

  -- Instantiate the Unit Under Test (UUT)
  uut: OUTPUT_LOGIC
    port map (
      result_in          => result_in,
      zero               => zero,
      invalid_in         => invalid_in,
      inf                => inf,
      overflow_underflow => overflow_underflow,
      result_out         => result_out,
      invalid_out        => invalid_out
    );

  -- Stimulus process

  stim_proc: process
  begin
    -- hold reset state for 100 ns.
    wait for 100 ns;

    -- Test case 1
    result_in <= MOCK_RESULT;
    zero <= '1';
    invalid_in <= '0';
    inf <= '0';
    overflow_underflow <= '0';

    EXPECTED_RESULT <= (others => '0');
    EXPECTED_INVALID <= '0';
    wait for 50 ns;
    assert result_out = EXPECTED_RESULT and invalid_out = EXPECTED_INVALID
      report "Test case 1 failed"
      severity error;

    -- Test case 2
    result_in <= MOCK_RESULT;
    zero <= '0';
    invalid_in <= '1';
    inf <= '0';
    overflow_underflow <= '0';

    EXPECTED_RESULT <= (others => '-');
    EXPECTED_INVALID <= '1';
    wait for 50 ns;
    assert result_out = EXPECTED_RESULT and invalid_out = EXPECTED_INVALID
      report "Test case 2 failed"
      severity error;

    -- Test case 3
    result_in <= MOCK_RESULT;
    zero <= '0';
    invalid_in <= '0';
    inf <= '1';
    overflow_underflow <= '0';

    EXPECTED_RESULT <= MOCK_RESULT(31) & "1111111100000000000000000000000";
    EXPECTED_INVALID <= '0';
    wait for 50 ns;
    assert result_out = EXPECTED_RESULT and invalid_out = EXPECTED_INVALID
      report "Test case 3 failed"
      severity error;

    -- Test case 4
    result_in <= MOCK_RESULT;
    zero <= '0';
    invalid_in <= '0';
    inf <= '0';
    overflow_underflow <= '1';

    EXPECTED_RESULT <= (others => '-');
    EXPECTED_INVALID <= '1';
    wait for 50 ns;
    assert result_out = EXPECTED_RESULT and invalid_out = EXPECTED_INVALID
      report "Test case 4 failed"
      severity error;

    -- Test case 5
    result_in <= MOCK_RESULT;
    zero <= '0';
    invalid_in <= '0';
    inf <= '0';
    overflow_underflow <= '0';

    EXPECTED_RESULT <= MOCK_RESULT;
    EXPECTED_INVALID <= '0';
    wait for 50 ns;
    assert result_out = EXPECTED_RESULT and invalid_out = EXPECTED_INVALID
      report "Test case 5 failed"
      severity error;

    wait;
  end process;

end architecture;

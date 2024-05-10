library ieee;
  use ieee.std_logic_1164.all;

entity TB_PIPELINED_MULT is
end entity;

architecture behavior of TB_PIPELINED_MULT is
  component PIPELINED_MULT
    port (
      X              : in  STD_LOGIC_VECTOR(31 downto 0);
      Y              : in  STD_LOGIC_VECTOR(31 downto 0);
      CLK            : in  STD_LOGIC;
      RST            : in  STD_LOGIC;
      P              : out STD_LOGIC_VECTOR(31 downto 0);
      invalid_output : out STD_LOGIC
    );
  end component;

  --Inputs
  signal input_X : STD_LOGIC_VECTOR(31 downto 0);
  signal input_Y : STD_LOGIC_VECTOR(31 downto 0);
  signal CLK     : std_logic := '0';
  signal rst     : STD_LOGIC := '0';

  --Outputs
  signal P              : STD_LOGIC_VECTOR(31 downto 0);
  signal invalid_output : STD_LOGIC;

  -- Utils 
  signal expected_output         : STD_LOGIC_VECTOR(31 downto 0);
  signal expected_invalid_output : STD_LOGIC;

  constant One            : STD_LOGIC_VECTOR(31 downto 0) := "00111111100000000000000000000000";
  constant LargestDenorm  : STD_LOGIC_VECTOR(31 downto 0) := "00000000011111111111111111111111";
  constant LargestNorm    : STD_LOGIC_VECTOR(31 downto 0) := "01111111011111111111111111111111";
  constant SmallestDenorm : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000001";
  constant SmallestNorm   : STD_LOGIC_VECTOR(31 downto 0) := "00000000100000000000000000000000";

  constant Zero             : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
  constant NegativeInfinity : STD_LOGIC_VECTOR(31 downto 0) := "11111111100000000000000000000000";
  constant PositiveInfinity : STD_LOGIC_VECTOR(31 downto 0) := "01111111100000000000000000000000";
  constant NotANumber       : STD_LOGIC_VECTOR(31 downto 0) := "11111111110000001000010000000000";

  -- Clock period definitions
  constant CLK_period : time := 70 ns;
begin

  -- Instantiate the Unit Under Test (UUT)
  uut: PIPELINED_MULT
    port map (
      X              => input_X,
      Y              => input_Y,
      CLK            => clk,
      RST            => rst,
      P              => P,
      invalid_output => invalid_output
    );

  -- Clock process definitions

  CLK_process: process
  begin
    CLK <= '0';
    wait for CLK_period / 2;
    CLK <= '1';
    wait for CLK_period / 2;
  end process;

  -- Stimulus process

  stim_proc: process
  begin
    -- hold reset state for 100 ns.
    RST <= '1';
    wait for CLK_period * 3;
    RST <= '0';
    wait for CLK_period / 2;

    -- Edge cases tests
    -- Zero results: we should get 0 as a result
    expected_output <= Zero;
    expected_invalid_output <= '0';

    -- 0 * 0 = 0
    input_X <= Zero;
    input_Y <= Zero;
    wait for CLK_period;

    -- 0 * Norm = 0
    input_X <= Zero;
    input_Y <= LargestNorm;
    wait for CLK_period;

    -- 0 * Denorm = 0
    input_X <= Zero;
    input_Y <= LargestDenorm;
    wait for CLK_period;

    assert (P = expected_output) and (invalid_output = expected_invalid_output) severity error;
    wait for CLK_period;
    assert (P = expected_output) and (invalid_output = expected_invalid_output) severity error;
    wait for CLK_period;
    assert (P = expected_output) and (invalid_output = expected_invalid_output) severity error;

    -- Infinity results: we should get Infinity as a result
    expected_output <= PositiveInfinity;
    expected_invalid_output <= '0';

    -- Infinity * Infinity = +Infinity
    input_X <= PositiveInfinity;
    input_Y <= PositiveInfinity;
    wait for CLK_period;

    -- Infinity * Norm = Infinity
    input_X <= PositiveInfinity;
    input_Y <= LargestNorm;
    wait for CLK_period;

    -- Infinity * Denorm = Infinity
    input_X <= PositiveInfinity;
    input_Y <= LargestDenorm;
    wait for CLK_period;

    assert (P = expected_output) and (invalid_output = expected_invalid_output) severity error;
    wait for CLK_period;
    assert (P = expected_output) and (invalid_output = expected_invalid_output) severity error;
    wait for CLK_period;
    assert (P = expected_output) and (invalid_output = expected_invalid_output) severity error;

    -- Invalid results: we should get invalid as a result since the multiplication is not possible
    expected_output <= (others => '-');
    expected_invalid_output <= '1';

    -- NaN * NaN = NaN
    input_X <= NotANumber;
    input_Y <= NotANumber;
    wait for CLK_period;

    -- NaN * Norm = NaN
    input_X <= NotANumber;
    input_Y <= LargestNorm;
    wait for CLK_period;

    -- NaN * Denorm = NaN
    input_X <= NotANumber;
    input_Y <= LargestDenorm;
    wait for CLK_period;
    assert (invalid_output = expected_invalid_output) severity error;

    -- NaN * 0 = NaN
    input_X <= NotANumber;
    input_Y <= Zero;
    wait for CLK_period;
    assert (invalid_output = expected_invalid_output) severity error;

    -- NaN * Infinity = NaN
    input_X <= NotANumber;
    input_Y <= PositiveInfinity;
    wait for CLK_period;

    assert (invalid_output = expected_invalid_output) severity error;
    wait for CLK_period;
    assert (invalid_output = expected_invalid_output) severity error;
    wait for CLK_period;
    assert (invalid_output = expected_invalid_output) severity error;

    -- TODO: Write more meaningful tests
    -- Test 1
    input_X <= "00111111100000000000000000000000";
    input_Y <= "00111111100000000000000000000000";
    wait for CLK_period;

    -- Test 2
    input_X <= "11000000000001100110011001100110";
    input_Y <= "01000000101111001100110011001101";
    wait for CLK_period;

    -- Test 3
    input_X <= "11110001111111110000000011111111";
    input_Y <= "01001011010000111110000100000011";
    wait for CLK_period;
    expected_output <= "00111111100000000000000000000000";
    expected_invalid_output <= '0';
    assert (P = expected_output) and (invalid_output = expected_invalid_output) report "Test 1 failed" severity error;

    -- Test 4
    input_X <= "10000000000001110001110011111111";
    input_Y <= "01111111011111111110000100000011";
    wait for CLK_period;
    expected_output <= "11000001010001100011110101110000";
    expected_invalid_output <= '0';
    assert (P = expected_output) and (invalid_output = expected_invalid_output) report "Test 2 failed" severity error;

    -- Test 5
    input_X <= "11111111100000000000000000000000";
    input_Y <= "01101111011110000000000100000011";
    wait for CLK_period;
    expected_output <= "11111101110000110001110111100101";
    expected_invalid_output <= '0';
    assert (P = expected_output) and (invalid_output = expected_invalid_output) report "Test 3 failed" severity error;

    wait for CLK_period;

    wait for CLK_period;
    expected_output <= "11111111100000000000000000000000";
    expected_invalid_output <= '0';
    assert (P = expected_output) and (invalid_output = expected_invalid_output) report "Test 5 failed" severity error;

    wait;
  end process;

end architecture;

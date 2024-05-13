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
    wait for CLK_period;

    input_X <= PositiveInfinity;
    input_Y <= LargestDenorm;

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

    -- Test 1: 1.0 * 1.0 = 1.0
    input_X <= One;
    input_Y <= One;
    wait for CLK_period;

    -- Test 2: 3.3 * 7.3 = 24.09
    input_X <= "01000000010100110011001100110011";
    input_Y <= "01000000111010011001100110011010";
    wait for CLK_period;

    -- Test 3: Denorm * Denorm = Underflow
    input_X <= LargestDenorm;
    input_Y <= LargestDenorm;
    wait for CLK_period;
    expected_output <= One; -- Test 1 Expected output
    expected_invalid_output <= '0';
    assert (P = expected_output) and (invalid_output = expected_invalid_output) report "Test 1 failed" severity error;

    --Test 4: Largest * Largest = Overflow
    input_X <= LargestNorm;
    input_Y <= LargestNorm;
    wait for CLK_period;
    expected_output <= "01000001110000001011100001010010"; -- Test 2 Expected output
    expected_invalid_output <= '0';
    assert (P = expected_output) and (invalid_output = expected_invalid_output) report "Test 2 failed" severity error;

    -- Test 5: Norm * Denorm, 3.3 * 1.498672E-39 = 4.945617E-39 (Wich is a Denorm number)
    input_X <= "01000000010100110011001100110011";
    input_Y <= "00000000000100000101000110110000";
    wait for CLK_period;
    expected_output <= Zero; -- Test 3 Expected output
    expected_invalid_output <= '0';
    assert (P = expected_output) and (invalid_output = expected_invalid_output) report "Test 3 failed" severity error;

    -- Test 6: Very Small Norm * Very Small Denorm, 7.7582626E-38 * 1.498672E-39 = Underflow
    input_X <= "00000001110100110011001100110011";
    input_Y <= "00000000000100000101000110110000";
    wait for CLK_period;
    expected_output <= PositiveInfinity; -- Test 4 Expected output
    expected_invalid_output <= '0';
    assert (P = expected_output) and (invalid_output = expected_invalid_output) report "Test 4 failed" severity error;

    -- Test 7: Norm * Denorm, 9.879754E-39 * 9.86454E33 = 9.7459226E-5 (Wich is a Norm number)
    input_X <= "00000000011010111001010010111100";
    input_Y <= "01110111111100110010111000000000";
    wait for CLK_period;
    expected_output <= "00000000001101011101101001011110"; -- Test 5 Expected output
    expected_invalid_output <= '0';
    assert (P = expected_output) and (invalid_output = expected_invalid_output) report "Test 5 failed" severity error;

    wait for CLK_period;
    expected_output <= Zero; -- Test 6 Expected output
    expected_invalid_output <= '0';
    assert (P = expected_output) and (invalid_output = expected_invalid_output) report "Test 6 failed" severity error;

    wait for CLK_period;
    expected_output <= "00111000110011000110001100000110"; -- Test 7 Expected output
    expected_invalid_output <= '0';
    assert (P = expected_output) and (invalid_output = expected_invalid_output) report "Test 7 failed" severity error;
    wait;
  end process;

end architecture;

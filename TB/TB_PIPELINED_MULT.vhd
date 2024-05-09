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

  --utils 
  signal expected_output         : STD_LOGIC_VECTOR(31 downto 0);
  signal expected_invalid_output : STD_LOGIC;

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
    expected_output <= "10111110011000111000010001010010";
    expected_invalid_output <= '0';
    assert (P = expected_output) and (invalid_output = expected_invalid_output) report "Test 4 failed" severity error;

    wait for CLK_period;
    expected_output <= "11111111100000000000000000000000";
    expected_invalid_output <= '0';
    assert (P = expected_output) and (invalid_output = expected_invalid_output) report "Test 5 failed" severity error;

    wait;
  end process;

end architecture;

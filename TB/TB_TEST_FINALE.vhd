library ieee;
  use ieee.std_logic_1164.all;

entity TB_TEST_FINALE is
end entity;

architecture behavior of TB_TEST_FINALE is
  component TEST_FINALE
    port (
      X            : in  STD_LOGIC_VECTOR(31 downto 0);
      Y            : in  STD_LOGIC_VECTOR(31 downto 0);
      P       : out STD_LOGIC_VECTOR(31 downto 0);
      invalid : out STD_LOGIC
    );
  end component;

  --Inputs
  signal input_X : STD_LOGIC_VECTOR(31 downto 0);
  signal input_Y : STD_LOGIC_VECTOR(31 downto 0);

  --Outputs
  signal output_final       : STD_LOGIC_VECTOR(31 downto 0);
  signal invalid_final : STD_LOGIC;

  -- Utility signals
  signal expected_output  : STD_LOGIC_VECTOR(31 downto 0);
  signal expected_invalid : STD_LOGIC;

begin

  -- Instantiate the Unit Under Test (UUT)
  uut: TEST_FINALE
    port map (
      X            => input_X,
      Y            => input_Y,
      P       => output_final,
      invalid => invalid_final
    );

  -- Stimulus process

  stim_proc: process
  begin
    -- hold reset state for 100 ns.
    wait for 100 ns;

    -- Test 1
    -- input_X <= "00111111100000000000000000000000";
    -- input_Y <= "00111111100000000000000000000000";

    -- expected_output <= "00111111100000000000000000000000";
    -- expected_invalid <= '0';
    -- wait for 50 ns;
    -- assert  (output_final = expected_output) and (invalid_final = expected_invalid) report "Test 1 failed" severity error;

    input_X <= "11000000000001100110011001100110";
    input_Y <= "01000000101111001100110011001101";

    expected_output <= "11000001010001100011110101110000";
    expected_invalid <= '0';
    wait for 50 ns;
    assert  (output_final = expected_output) and (invalid_final = expected_invalid) report "Test 2 failed" severity error;

    wait;
  end process;

end architecture;

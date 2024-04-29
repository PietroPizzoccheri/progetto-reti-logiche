library ieee;
  use ieee.std_logic_1164.all;

  -- Uncomment the following library declaration if using
  -- arithmetic functions with Signed or Unsigned values
  --USE ieee.numeric_std.ALL;

entity TB_SHIFTER is
end entity;

architecture behavior of TB_SHIFTER is

  -- Component Declaration for the Unit Under Test (UUT)
  component SHIFTER
    port (
      CLK     : in  std_logic;
      MANTIX  : in  std_logic_vector(22 downto 0);
      SHIFTED : out std_logic_vector(22 downto 0)
    );
  end component;

  --Inputs
  signal CLK    : std_logic                     := '0';
  signal MANTIX : std_logic_vector(22 downto 0) := (others => '0');

  --Outputs
  signal SHIFTED          : std_logic_vector(22 downto 0);
  signal EXPECTED_SHIFTED : std_logic_vector(22 downto 0);

  -- Clock period definitions
  constant CLK_period : time := 10 ns;

begin

  -- Instantiate the Unit Under Test (UUT)
  uut: SHIFTER
    port map (
      CLK     => CLK,
      MANTIX  => MANTIX,
      SHIFTED => SHIFTED
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
    -- wait for 100 ns;
    -- Test that the shifter works correctly
    MANTIX <= "00000000000000000000010";
    EXPECTED_SHIFTED <= "00000000000000001000000";
    wait for CLK_period * 5;
    assert SHIFTED = EXPECTED_SHIFTED
      report "Test case 1 failed"
      severity error;

    MANTIX <= "00000000000000000000000";
    wait;
  end process;

end architecture;

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
  signal SHIFTED : std_logic_vector(22 downto 0);

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
    wait for 100 ns;

    -- Test case 1
    MANTIX <= "00000000000000000000001";
    wait for CLK_period;
    assert SHIFTED = "00000000000000000000010" report "Test case 1 failed" severity error;

    -- Test case 2: Input is '00000000000000000000010'
    MANTIX <= "00000000000000000000010";
    wait for CLK_period;
    assert SHIFTED = "00000000000000000000100" report "Test case 2 failed" severity error;

    -- Test case 3
    MANTIX <= "00000000000000000000100";
    wait for CLK_period;
    assert SHIFTED = "00000000000000000001000" report "Test case 3 failed" severity error;

    -- Test case 4
    MANTIX <= "00000000000000000001000";
    wait for CLK_period;
    assert SHIFTED = "00000000000000000010000" report "Test case 4 failed" severity error;

    -- Test case 5
    MANTIX <= "00000000000000000010000";
    wait for CLK_period;
    assert SHIFTED = "00000000000000000100000" report "Test case 5 failed" severity error;

    wait;
  end process;

end architecture;

library ieee;
  use ieee.std_logic_1164.all;

entity TB_NORMALIZER is
end entity;

architecture behavior of TB_NORMALIZER is

  -- Component Declaration for the Unit Under Test (UUT)
  component NORMALIZER is
    port (
      MANTIX            : in  STD_LOGIC_VECTOR(22 downto 0);
      CLK               : in  STD_LOGIC;
      RESET             : in  STD_LOGIC;
      BIAS_EXIT         : out STD_LOGIC_VECTOR(4 downto 0);
      MANTIX_NORMALIZED : out STD_LOGIC_VECTOR(22 downto 0)
    );
  end component;

  --Inputs
  signal MANTIX : STD_LOGIC_VECTOR(22 downto 0) := (others => '0');
  signal CLK    : STD_LOGIC                     := '0';
  signal RESET  : STD_LOGIC                     := '0';

  --Outputs
  signal BIAS_EXIT         : STD_LOGIC_VECTOR(4 downto 0);
  signal MANTIX_NORMALIZED : STD_LOGIC_VECTOR(22 downto 0);

  constant CLK_period : time := 10 ns;

begin

  -- Instantiate the Unit Under Test (UUT)
  uut: NORMALIZER
    port map (
      MANTIX            => MANTIX,
      CLK               => CLK,
      RESET             => RESET,
      BIAS_EXIT         => BIAS_EXIT,
      MANTIX_NORMALIZED => MANTIX_NORMALIZED
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
    -- -- hold reset state for 100 ns.
    -- wait for 100 ns;
    -- Test case 1
    MANTIX <= "00000111110101010010101";
    wait for CLK_period * 23;
    assert MANTIX_NORMALIZED = "11111010101001010100000" report "Test case 1 failed" severity error;

    -- Test case 2
    MANTIX <= "00000000000000000000001";
    wait for CLK_period * 23;
    assert MANTIX_NORMALIZED = "10000000000000000000000" report "Test case 2 failed" severity error;

    -- Test case 3
    MANTIX <= "00000000000000000100000";
    wait for CLK_period * 23;
    assert MANTIX_NORMALIZED = "10000000000000000000000" report "Test case 3 failed" severity error;

    -- Test case 4
    MANTIX <= "00000000000010000000000";
    wait for CLK_period * 23;
    assert MANTIX_NORMALIZED = "10000000000000000000000" report "Test case 4 failed" severity error;

    wait;
  end process;

end architecture;

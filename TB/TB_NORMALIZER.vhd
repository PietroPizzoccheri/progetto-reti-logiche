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
    -- Worst case scenario
    MANTIX <= "00000000000000000000001";
    wait for CLK_period * 24;
    assert MANTIX_NORMALIZED = "00000000000000000000000" report "Worst case scenario wrong mantix" severity error;
    assert BIAS_EXIT = "10111" report "Worst case scenario wrong bias" severity error;
    RESET <= '1';
    wait for CLK_period;
    RESET <= '0';

    -- Best case scenario
    MANTIX <= "10000000000000000000000";
    wait for CLK_period * 24;
    assert MANTIX_NORMALIZED = "00000000000000000000000" report "Best case scenario wrong mantix" severity error;
    assert BIAS_EXIT = "00001" report "Best case scenario wrong bias" severity error;
    RESET <= '1';
    wait for CLK_period;
    RESET <= '0';

    -- Random case scenario
    MANTIX <= "00001111000000000000000";
    wait for CLK_period * 24;
    assert MANTIX_NORMALIZED = "11100000000000000000000" report "Random case scenario wrong mantix" severity error;
    assert BIAS_EXIT = "00101" report "Random case scenario wrong bias" severity error;
    RESET <= '1';
    wait for CLK_period;
    RESET <= '0';

    MANTIX <= (others => '0');
    wait;
  end process;

end architecture;

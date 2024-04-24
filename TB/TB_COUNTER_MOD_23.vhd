library ieee;
  use ieee.std_logic_1164.all;

entity TB_COUNTER_MOD_23 is
end entity;

architecture behavior of TB_COUNTER_MOD_23 is

  -- Component Declaration for the Unit Under Test (UUT)
  component COUNTER_MOD_23
    port (
      CLK   : in  std_logic;
      RESET : in  std_logic;
      Y     : out std_logic_vector(4 downto 0)
    );
  end component;

  --Inputs
  signal CLK   : std_logic := '0';
  signal RESET : std_logic := '0';

  --Outputs
  signal Y : std_logic_vector(4 downto 0);

  -- Clock period definitions
  constant CLK_period : time := 10 ns;

begin

  -- Instantiate the Unit Under Test (UUT)
  uut: COUNTER_MOD_23
    port map (
      CLK   => CLK,
      RESET => RESET,
      Y     => Y
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

    wait for CLK_period * 33;
    wait;
  end process;

end architecture;

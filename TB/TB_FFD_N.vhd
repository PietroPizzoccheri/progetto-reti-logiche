library ieee;
  use ieee.std_logic_1164.all;

entity TB_FFD_N is
end entity;

architecture behavior of TB_FFD_N is

  -- Component Declaration for the Unit Under Test (UUT)
  component FFD_N
    generic (
      N : integer := FFBITS
    );
    port (
      CLK : in  std_logic;
      D   : in  std_logic_vector(N - 1 downto 0);
      Q   : out std_logic_vector(N - 1 downto 0)
    );
  end component;

  --Inputs
  signal CLK : std_logic                             := '0';
  signal D   : std_logic_vector(FFBITS - 1 downto 0) := (others => '0');

  --Outputs
  signal Q : std_logic_vector(FFBITS - 1 downto 0);

  -- Utility signals
  signal EXPECTED_Q : std_logic_vector(3 downto 0);

  -- Clock period definitions
  constant CLK_period : time    := 10 ns;
  constant FFBITS     : integer := 4;

begin

  -- Instantiate the Unit Under Test (UUT)
  uut: FFD_N
    generic map (
      N => FFBITS
    )
    port map (
      CLK => CLK,
      D   => D,
      Q   => Q
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

    wait for CLK_period * 10;

    -- insert stimulus here 
    D <= "0001";
    EXPECTED_Q <= "0001";
    wait for CLK_period;
    assert Q = EXPECTED_Q report "Test failed for D = 0001" severity error;

    wait;
  end process;

end architecture;

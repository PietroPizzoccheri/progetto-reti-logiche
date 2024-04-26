library ieee;
  use ieee.std_logic_1164.all;

entity TB_NORMALIZER is
end entity;

architecture behavior of TB_NORMALIZER is

  -- Component Declaration for the Unit Under Test (UUT)
  component NORMALIZER is
    port (
      MANTIX            : in  STD_LOGIC_VECTOR(22 downto 0);
      Clock             : in  STD_LOGIC;
      BIAS_EXIT         : out STD_LOGIC_VECTOR(4 downto 0);
      MANTIX_NORMALIZED : out STD_LOGIC_VECTOR(22 downto 0)
    );
  end component;

  --Inputs
  signal MANTIX : STD_LOGIC_VECTOR(22 downto 0) := (others => '0');
  signal Clock  : STD_LOGIC                     := '0';

  --Outputs
  signal BIAS_EXIT         : STD_LOGIC_VECTOR(4 downto 0);
  signal MANTIX_NORMALIZED : STD_LOGIC_VECTOR(22 downto 0);

  constant CLK_period : time := 10 ns;

begin

  -- Instantiate the Unit Under Test (UUT)
  uut: NORMALIZER
    port map (
      MANTIX            => MANTIX,
      Clock             => Clock,
      BIAS_EXIT         => BIAS_EXIT,
      MANTIX_NORMALIZED => MANTIX_NORMALIZED
    );

  -- Clock process definitions
  

  CLK_process: process
  begin
    Clock <= '0';
    wait for CLK_period / 2;
    Clock <= '1';
    wait for CLK_period / 2;
  end process;

  -- Stimulus process
  stim_proc: process
  begin
    
    wait for 100 ns;

    MANTIX <= "00000000000000000000000";
    wait for CLK_period * 20;

    MANTIX <= "00000111110101010010101";
    wait for CLK_period * 20;

    MANTIX <= "00000000000000000000001";
    wait for CLK_period * 20;

    MANTIX <= "00000000000000000100000";
    wait for CLK_period * 20;

    MANTIX <= "00000000000010000000000";
    wait for CLK_period * 20;



    wait;
  end process;

end architecture;

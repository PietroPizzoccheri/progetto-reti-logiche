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
      MANTIX  : in  std_logic_vector(23 downto 0);
      SHIFTED : out std_logic_vector(23 downto 0);
      OFFSET  : out  std_logic_vector(4 downto 0)
    );
  end component;

  --Inputs
  signal MANTIX : std_logic_vector(23 downto 0);

  --Outputs
  signal SHIFTED          : std_logic_vector(23 downto 0);
  signal OFFSET           : std_logic_vector(4 downto 0);

begin
  -- Instantiate the Unit Under Test (UUT)
  uut: SHIFTER
    port map (
      MANTIX  => MANTIX,
      SHIFTED => SHIFTED,
      OFFSET  => OFFSET
    );



  -- Stimulus process

  stim_proc : process
  begin
    
    MANTIX <= "000000000000000000000000"; 
    wait for 50 ns;

    MANTIX <= "000010000000000110000000"; 
    wait for 50 ns;

    MANTIX <= "000000000001111111111111"; 
    wait for 50 ns;

    MANTIX <= "000000000000000100000000"; 
    wait for 50 ns;

    MANTIX <= "000111111110000000000000"; 
    wait for 50 ns;

    MANTIX <= "000000000011111111100000"; 
    wait for 50 ns;

    MANTIX <= "001111011101010010100000"; 
    wait for 50 ns;

    MANTIX <= "000000000000000000000001";
    wait;
  end process;

end architecture;

library ieee;
  use ieee.std_logic_1164.all;

entity TB_SHIFTER is
end entity;

architecture behavior of TB_SHIFTER is

  -- Component Declaration for the Unit Under Test (UUT)
  component SHIFTER
    port (
      MANTIX  : in  STD_LOGIC_VECTOR(22 downto 0);
      SHIFTED : out STD_LOGIC_VECTOR(22 downto 0)
    );
  end component;

  --Inputs
  signal MANTIX : std_logic_vector(22 downto 0);

  --Outputs
  signal SHIFTED : std_logic_vector(22 downto 0);
  -- No clocks detected in port list. Replace <clock> below with 
  -- appropriate port name 

begin

  -- Instantiate the Unit Under Test (UUT)
  uut: SHIFTER
    port map (
      MANTIX  => MANTIX,
      SHIFTED => SHIFTED
    );

  -- Stimulus process
  process
  begin
    MANTIX <= "00000000000000000000000";
    wait for 20 ns;

    MANTIX <= "00000000011100000000000";
    wait for 20 ns;

    MANTIX <= "00000000111111000000000";
    wait for 20 ns;

    MANTIX <= "00111110000000000000000";
    wait for 20 ns;

    MANTIX <= "00000000000000000011100";
    wait for 20 ns;

    MANTIX <= "11111111111100000000000";
    wait;

  end process;

end architecture;

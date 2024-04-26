library ieee;
  use ieee.std_logic_1164.all;

entity TB_EXP_ADDER is
end entity;

architecture behavior of TB_EXP_ADDER is

  -- Component Declaration for the Unit Under Test (UUT)
  component TB_EXP_ADDER
    port (
      E1  : in  STD_LOGIC_VECTOR(7 downto 0);
      E2  : in  STD_LOGIC_VECTOR(7 downto 0);
      sum : out STD_LOGIC_VECTOR(8 downto 0)
    );
  end component;

  --Inputs
  signal E1 : std_logic_vector(7 downto 0) := (others => '0');
  signal E2 : std_logic_vector(7 downto 0) := (others => '0');

  --Outputs
  signal sum : std_logic_vector(8 downto 0);

begin

  -- Instantiate the Unit Under Test (UUT)
  uut: TB_EXP_ADDER
    port map (
      E1  => E1,
      E2  => E2,
      sum => sum
    );

  -- Clock process definitions


  -- Stimulus process

  stim_proc: process
  begin
    E1 <= "00000000";
    E2 <= "00000000";
    wait for 20 ns;

    E1 <= "01110000";
    E2 <= "00001110";
    wait for 20 ns;

    E1 <= "11111111";
    E2 <= "00100000";
    wait for 20 ns;

    E1 <= "11111111";
    E2 <= "11111111";
    wait for 20 ns;

    E1 <= "11110000";
    E2 <= "00011111";
    wait for 20 ns;

    E1 <= "11110000";
    E2 <= "10011111";
    wait;
  end process;

end architecture;

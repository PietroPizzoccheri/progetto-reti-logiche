library ieee;
  use ieee.std_logic_1164.all;

entity TB_CLA_8 is
end entity;

architecture behavior of TB_CLA_8 is

  -- Component Declaration for the Unit Under Test (UUT)
  -- Testing for CLA with 5 bits
  component CLA_8
    port (
      X    : in  std_logic_vector(7 downto 0);
      Y    : in  std_logic_vector(7 downto 0);
      S    : out std_logic_vector(7 downto 0);
      Cin  : in  std_logic;
      Cout : out std_logic
    );
  end component;

  --Inputs
  signal X   : std_logic_vector(7 downto 0) := (others => '0');
  signal Y   : std_logic_vector(7 downto 0) := (others => '0');
  signal Cin : std_logic                    := '0';

  --Outputs
  signal S    : std_logic_vector(7 downto 0);
  signal S_9  : std_logic_vector(8 downto 0);
  signal Cout : std_logic;

  signal EXPECTED_S    : std_logic_vector(7 downto 0);
  signal EXPECTED_COUT : std_logic;
begin

  -- Instantiate the Unit Under Test (UUT)
  uut: CLA_8
    port map (
      X    => X,
      Y    => Y,
      S    => S,
      Cin  => Cin,
      Cout => Cout
    );
    S_9 <= Cout & S;

  -- Stimulus process
  process
  begin

    X <= "11111111";
    Y <= "11111111";
    Cin <= '0';
    wait for 100 ns;

    X <= "00000000";
    Y <= "00000000";
    Cin <= '0';
    wait for 100 ns;

    X <= "00011000";
    Y <= "00000010";
    Cin <= '0';
    wait for 100 ns;

    X <= "10100000";
    Y <= "01100000";
    Cin <= '0';
    wait for 100 ns;

    X <= "01000100";
    Y <= "01100000";
    Cin <= '0';
    wait for 100 ns;

    X <= "00011000";
    Y <= "01111100";
    Cin <= '0';
    wait for 100 ns;

    X <= "00011000";
    Y <= "01111111";
    Cin <= '0';
    wait;

  end process;

end architecture;

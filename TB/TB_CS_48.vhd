library ieee;
  use ieee.std_logic_1164.all;

entity TB_CS_48 is
end entity;

architecture behavior of TB_CS_48 is

  -- Component Declaration for the Unit Under Test (UUT)
  -- Testing for CLA with 5 bits
  component CS_48
    port (
      X    : in  std_logic_vector(47 downto 0);
      Y    : in  std_logic_vector(47 downto 0);
      S    : out std_logic_vector(47 downto 0);
      Cin  : in  std_logic;
      Cout : out std_logic
    );
  end component;

  --Inputs
  signal X   : std_logic_vector(47 downto 0) := (others => '0');
  signal Y   : std_logic_vector(47 downto 0) := (others => '0');
  signal Cin : std_logic                    := '0';

  --Outputs
  signal S    : std_logic_vector(47 downto 0);
  signal S_9  : std_logic_vector(48 downto 0);
  signal Cout : std_logic;

  --Utils
  

begin

  -- Instantiate the Unit Under Test (UUT)
  uut: CS_48
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

    X <= "111111111111111111110101010010101101010001011111";
    Y <= "111111111111111111111111111111111010101111111111";
    Cin <= '0';
    wait for 100 ns;

    X <= "001101100011111111111111110101000010100001010101";
    Y <= "111111101101010101111111110100101001010111010101";
    Cin <= '0';
    wait for 100 ns;

    X <= "000110101011011111111111110101001010101010111000";
    Y <= "011111101000110100101011110101001010101101011011";
    Cin <= '0';
    wait;

  end process;

end architecture;

library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity CLA_12 is
  port (
    X, Y : in  std_logic_vector(11 downto 0);
    S    : out std_logic_vector(11 downto 0);
    Cin  : in  std_logic;
    Cout : out std_logic
  );
end entity;

-- Pag. 175

architecture rtl of CLA_12 is

  component CLA_4 is
    port (
      X, Y : in  std_logic_vector(3 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(3 downto 0);
      Cout : out std_logic
    );
  end component;

  signal Cout0, Cout1 : std_logic;

begin

  CLA0: CLA_4 port map (X(3 downto 0) , y(3 downto 0), Cin, S(3 downto 0), Cout0);
  CLA1: CLA_4 port map (X(7 downto 4) , y(7 downto 4), Cout0, S(7 downto 4), Cout1);
  CLA2: CLA_4 port map (X(11 downto 8), y(11 downto 8), Cout1, S(11 downto 8), Cout);

end architecture;

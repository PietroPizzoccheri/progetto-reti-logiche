library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity CLA_48 is
  port (
    X, Y : in  std_logic_vector(47 downto 0);
    S    : out std_logic_vector(47 downto 0);
    Cin  : in  std_logic;
    Cout : out std_logic
  );
end entity;

-- Pag. 175

architecture rtl of CLA_48 is

  component CLA_8 is
    port (
      X, Y : in  std_logic_vector(7 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(7 downto 0);
      Cout : out std_logic
    );
  end component;

  signal Cout0, Cout1, Cout2, Cout3, Cout4 : std_logic;

begin
  CLA0: CLA_8 port map (X(7 downto 0), Y(7 downto 0), Cin, S(7 downto 0), Cout0);
  CLA1: CLA_8 port map (X(15 downto 8), Y(15 downto 8), Cout0, S(15 downto 8), Cout1);
  CLA2: CLA_8 port map (X(23 downto 16), Y(23 downto 16), Cout1, S(23 downto 16), Cout2);
  CLA3: CLA_8 port map (X(31 downto 24), Y(31 downto 24), Cout2, S(31 downto 24), Cout3);
  CLA4: CLA_8 port map (X(39 downto 32), Y(39 downto 32), Cout3, S(39 downto 32), Cout4);
  CLA5: CLA_8 port map (X(47 downto 40), Y(47 downto 40), Cout4, S(47 downto 40), Cout);
end architecture;

library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity CLA_10 is
  port (
    X, Y : in  std_logic_vector(9 downto 0);
    S    : out std_logic_vector(9 downto 0);
    Cin  : in  std_logic;
    Cout : out std_logic
  );
end entity;

-- 10-bit CLA made with 8-bit CLA in ripple-carry with 2-bit CLA

architecture rtl of CLA_10 is

  component CLA_2 is
    port (
      X, Y : in  std_logic_vector(1 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(1 downto 0);
      Cout : out std_logic
    );
  end component;

  component CLA_8 is
    port (
      X, Y : in  std_logic_vector(7 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(7 downto 0);
      Cout : out std_logic
    );
  end component;

  signal Cout0 : std_logic;

begin
  CLA0: CLA_8 port map (X(7 downto 0), Y(7 downto 0), Cin, S(7 downto 0), Cout0);
  CLA1: CLA_2 port map (X(9 downto 8), y(9 downto 8), Cout0, S(9 downto 8), Cout);
end architecture;

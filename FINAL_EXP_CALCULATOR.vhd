
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity FINAL_EXP_CALCULATOR is
  port (
    EXP    : in  STD_LOGIC_VECTOR(9 downto 0);
    OFFSET : in  STD_LOGIC_VECTOR(4 downto 0);
    SUB    : in  STD_LOGIC;
    S      : out STD_LOGIC_VECTOR(9 downto 0)
  );
end entity;

architecture RTL of FINAL_EXP_CALCULATOR is

  component CLA_10 is
    port (
      X, Y : in  std_logic_vector(9 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(9 downto 0);
      Cout : out std_logic
    );
  end component;

  signal OFFSET_10     : std_logic_vector(9 downto 0);
  signal OFFSET_TO_ADD : std_logic_vector(9 downto 0);
  signal EXTENDED_SUB  : std_logic_vector(9 downto 0);
  signal SUB_SIG       : std_logic;

begin
  OFFSET_10     <= "00000" & OFFSET; -- pad with 0s
  EXTENDED_SUB  <= (others => SUB);
  OFFSET_TO_ADD <= EXTENDED_SUB xor OFFSET_10;
  SUB_SIG       <= SUB;

  adder: CLA_10
    port map (
      X    => EXP,
      Y    => OFFSET_TO_ADD,
      S    => S,
      Cin  => SUB_SIG,
      Cout => open
    );
end architecture;

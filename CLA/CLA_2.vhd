library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity CLA_2 is
  port (
    X, Y : in  std_logic_vector(1 downto 0);
    S    : out std_logic_vector(1 downto 0);
    Cin  : in  std_logic;
    Cout : out std_logic
  );
end entity;

architecture rtl of CLA_2 is
  component FA is
    port (
      X    : in  std_logic;
      Y    : in  std_logic;
      cin  : in  std_logic;
      S    : out std_logic;
      Cout : out std_logic
    );
  end component;

  signal C : std_logic_vector(2 downto 0) := (others => '0'); -- Carry
  signal P : std_logic_vector(1 downto 0) := (others => '0'); -- Propagate
  signal G : std_logic_vector(1 downto 0) := (others => '0'); -- Generate

begin
  G <= x and y; -- Generate bits
  P <= x or y;  -- Propagate bits

  C(1) <= G(0) or (P(0) and Cin);
  C(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and Cin);
  -- Compute the first sum separately with the Cin the input
  first_FA: FA
    port map (
      X    => x(0),
      Y    => y(0),
      cin  => Cin,
      S    => S(0),
      Cout => open
    );

  -- Compute the other sums with the carrys calculated by the CLAL
  FA_inst: FA
    port map (
      X    => x(1),
      Y    => y(1),
      cin  => C(1),
      S    => S(1),
      Cout => open -- We don't care about the carry out from the FAs
    );

  Cout <= C(2); -- Set the carry out to be the last carry from the CLL  

end architecture;



library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity CLA_4 is
  port (
    X, Y : in  std_logic_vector(3 downto 0);
    S    : out std_logic_vector(3 downto 0);
    Cin  : in  std_logic;
    Cout : out std_logic
  );
end entity;

architecture rtl of CLA_4 is
  component FA is
    port (
      X    : in  std_logic;
      Y    : in  std_logic;
      cin  : in  std_logic;
      S    : out std_logic;
      Cout : out std_logic
    );
  end component;

  signal C : std_logic_vector(4 downto 0) := (others => '0'); -- Carry
  signal P : std_logic_vector(3 downto 0) := (others => '0'); -- Propagate
  signal G : std_logic_vector(3 downto 0) := (others => '0'); -- Generate

begin
  G <= x and y; -- Generate bits
  P <= x or y;  -- Propagate bits

  C(1) <= G(0) or (P(0) and Cin);
  C(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and Cin);
  C(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and Cin);
  C(4) <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and Cin);

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
  gen_full_adders: for i in 1 to 3 generate
    FA_inst: FA
      port map (
        X    => x(i),
        Y    => y(i),
        cin  => C(i),
        S    => S(i),
        Cout => open -- We don't care about the carry out from the FAs
      );
  end generate;

  Cout <= C(4); -- Set the carry out to be the last carry from the CLL     

end architecture;



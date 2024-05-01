library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity CLA_46 is
  port (
    X, Y : in  std_logic_vector(46 - 1 downto 0);
    S    : out std_logic_vector(46 - 1 downto 0);
    Cin  : in  std_logic;
    Cout : out std_logic
  );
end entity;

-- Pag. 175

architecture rtl of CLA_46 is
  component FA is
    port (
      X    : in  std_logic;
      Y    : in  std_logic;
      cin  : in  std_logic;
      S    : out std_logic;
      Cout : out std_logic
    );
  end component;

  -- Initialize signals to 0
  signal C : std_logic_vector(46 downto 0)     := (others => '0'); -- Carry
  signal P : std_logic_vector(46 - 1 downto 0) := (others => '0'); -- Propagate
  signal G : std_logic_vector(46 - 1 downto 0) := (others => '0'); -- Generate

begin
  G <= x and y; -- Generate bits
  P <= x or y;  -- Propagate bits

  carry: process (C, P, G)
  begin
    clal: for i in 0 to 46 - 1 loop -- Carry Lookahead Logic
      if i = 0 then
        C(i + 1) <= G(i) or (P(i) and Cin); -- Compute the next carry
      else
        C(i + 1) <= G(i) or (P(i) and C(i)); -- Compute the next carry
      end if;
    end loop;
  end process;

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
  gen_full_adders: for i in 1 to 46 - 1 generate
    FA_inst: FA
      port map (
        X    => x(i),
        Y    => y(i),
        cin  => C(i),
        S    => S(i),
        Cout => open -- We don't care about the carry out from the FAs
      );
  end generate;

  Cout <= C(46); -- Set the carry out to be the last carry from the CLL     

end architecture;

library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity CLA_MUL_23 is
  port (
    X : in  std_logic_vector(22 downto 0);
    Y : in  std_logic_vector(22 downto 0);
    P : out std_logic_vector(45 downto 0)
  );
end entity;

architecture rtl of CLA_MUL_23 is
  component CLA_46 is
    port (
      X, Y : in  std_logic_vector(46 - 1 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(46 - 1 downto 0);
      Cout : out std_logic
    );
  end component;

  signal TEMP_X : std_logic_vector(45 downto 0);
  type T_t is array (0 to 23) of std_logic_vector(45 downto 0);
  signal T : T_t;
begin
  TEMP_X <= (22 downto 0 => '0') & X;

  gen_pp: for i in 0 to 22 generate
    TEMP_X <= TEMP_X(44 downto 0) & '0';
    T(i)   <= (45 downto 0 => Y(i)) and TEMP_X;
  end generate;

  gen_cla: for i in 0 to 22 generate
    CLA_46_i: CLA_46
      port map (
        X    => T(i),
        Y    => T(i + 1),
        Cin  => '0',
        S    => T(i + 1),
        Cout => open
      );
  end generate;

  P <= T(23);

end architecture;

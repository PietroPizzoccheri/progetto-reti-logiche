library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity CLA_MUL_23 is
  port (
    X : in  std_logic_vector(23 downto 0);
    Y : in  std_logic_vector(23 downto 0);
    P : out std_logic_vector(47 downto 0)
  );
end entity;


architecture rtl of CLA_MUL_23 is
  component CLA_48 is
    port (
      X, Y : in  std_logic_vector(47 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(47 downto 0);
      Cout : out std_logic
    );
  end component;

  type T_t is array (0 to 23) of std_logic_vector(47 downto 0);
  type T_temp_x is array (0 to 24) of std_logic_vector(47 downto 0);

  signal TEMP_X      : T_temp_x;
  signal TEMP_Y      : T_t;
  signal T           : T_t;
  signal PARTIAL_SUM : T_temp_x;
begin
  TEMP_X(0)      <= (23 downto 0 => '0') & X;
  PARTIAL_SUM(0) <= T(1);

  gen_pp: for i in 0 to 23 generate
    TEMP_Y(i)     <= (47 downto 0 => Y(i));
    TEMP_X(i + 1) <= TEMP_X(i)(46 downto 0) & '0';
    T(i)          <= TEMP_Y(i) and TEMP_X(i);
  end generate;

  CLA_48_0: CLA_48
    port map (
      X    => T(0),
      Y    => T(1),
      Cin  => '0',
      S    => PARTIAL_SUM(2),
      Cout => open
    );

  gen_cla: for i in 2 to 23 generate
    CLA_48_i: CLA_48
      port map (
        X    => T(i),
        Y    => PARTIAL_SUM(i),
        Cin  => '0',
        S    => PARTIAL_SUM(i + 1),
        Cout => open
      );
  end generate;

  P <= PARTIAL_SUM(24);
end architecture;

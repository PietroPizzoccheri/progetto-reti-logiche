library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity MUX_2_1_N is
  generic (
    N : integer
  );
  port (
    S : in  STD_LOGIC;
    A : in  STD_LOGIC_VECTOR(N - 1 downto 0);
    B : in  STD_LOGIC_VECTOR(N - 1 downto 0);
    Y : out STD_LOGIC_VECTOR(N - 1 downto 0)
  );
end entity;

architecture RTL of MUX_2_1_N is
begin
  Y <= (others => '0');
  gen: for i in 0 to N - 1 generate
    with S select
      Y(i) <= A(i) when '0',
              B(i) when '1',
              '-'  when others;
  end generate;
end architecture;

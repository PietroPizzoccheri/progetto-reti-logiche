library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity MUX_23_1 is

  port (
    S : in  STD_LOGIC;
    A : in  std_logic_vector(22 downto 0);
    B : in  std_logic_vector(22 downto 0);
    Y : out std_logic_vector(22 downto 0)
  );
end entity;

architecture RTL of MUX_23_1 is
begin
  with S select
    y <= A   when '0',
         B   when others;
end architecture;

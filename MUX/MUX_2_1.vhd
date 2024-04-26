library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity MUX_2_1 is

  port (
    S : in  STD_LOGIC;
    A : in  STD_LOGIC;
    B : in  STD_LOGIC;
    Y : out STD_LOGIC
  );
end entity;

architecture RTL of MUX_2_1 is
begin
  with S select
    y <= A   when '0',
         B   when '1',
         '-' when others;
end architecture;

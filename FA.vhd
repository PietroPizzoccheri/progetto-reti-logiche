library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity FA is
  port (
    X, Y, Cin : in  STD_LOGIC;
    S, Cout   : out STD_LOGIC
  );
end entity;

architecture rtl of FA is
begin
  S    <= X xor Y xor Cin;
  Cout <= (X and Y) or (Y and Cin) or (X and Cin);
end architecture;

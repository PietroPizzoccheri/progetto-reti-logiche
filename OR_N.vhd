library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity OR_N is
  generic (
    N : integer
  );
  port (
    A : in  STD_LOGIC_VECTOR(N - 1 downto 0);
    Y : out std_logic
  );
end entity;

architecture RTL of OR_N is
begin
  OR_LOGIC: process (A)
  begin
    Y <= '0'; -- Initialize output to '0'
    for i in A'range loop
      Y <= Y or A(i); -- Perform OR operation on each bit
    end loop;
  end process;
end architecture;

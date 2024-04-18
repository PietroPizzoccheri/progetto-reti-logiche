library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity AND_N is
  generic (
    N : integer
  );
  port (
    A : in  STD_LOGIC_VECTOR(N - 1 downto 0);
    Y : out std_logic
  );
end entity;

architecture RTL of AND_N is
begin
  AND_LOGIC: process (A)
  begin
    Y <= '1'; -- Initialize output to '1'
    for i in A'range loop
      Y <= Y and A(i); -- Perform AND operation on each bit
      if Y = '0' then -- If Y becomes '0', no need to continue
        exit;
      end if;
    end loop;
  end process;
end architecture;

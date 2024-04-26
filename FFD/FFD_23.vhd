library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity FFD_23 is
  port (CLK : in  std_logic;
        D   : in  std_logic_vector(22 downto 0);
        Q   : out std_logic_vector(22 downto 0)
       );
end entity;

architecture rtl_rising_edge of FFD_23 is
begin
  ff: process (CLK)
  begin
    if (CLK'event and CLK = '1') then
      Q <= D;
    end if;
  end process;
end architecture;

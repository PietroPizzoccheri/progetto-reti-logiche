library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity SHIFTER is
  port (
    CLK     : in  STD_LOGIC;
    MANTIX  : in  STD_LOGIC_VECTOR(22 downto 0);
    SHIFTED : out STD_LOGIC_VECTOR(22 downto 0)
  );
end entity;

architecture RTL of SHIFTER is

begin
  ff: process (CLK)
  begin
    if (CLK'event and CLK = '1') then
      SHIFTED <= MANTIX(21 downto 0) & "0";
    end if;
  end process;

end architecture;


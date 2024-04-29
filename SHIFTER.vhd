library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity SHIFTER is
  port (
    CLK     : in  STD_LOGIC;
    RESET   : in  std_logic;
    MANTIX  : in  STD_LOGIC_VECTOR(22 downto 0);
    SHIFTED : out STD_LOGIC_VECTOR(22 downto 0)
  );
end entity;

architecture RTL of SHIFTER is

  signal SHIFTED_TEMP : STD_LOGIC_VECTOR(22 downto 0) := (others => 'U');

begin
  shift: process (CLK, RESET)
  begin
    -- Async reset
    if (RESET = '1') then
      SHIFTED_TEMP <= (others => 'U');
    elsif (CLK'event and CLK = '1') then
      if (SHIFTED_TEMP = "UUUUUUUUUUUUUUUUUUUUUUU") then
        SHIFTED_TEMP <= MANTIX(21 downto 0) & "0";
      else
        SHIFTED_TEMP <= SHIFTED_TEMP(21 downto 0) & "0";
      end if;
    end if;
  end process;

  SHIFTED <= SHIFTED_TEMP;
end architecture;


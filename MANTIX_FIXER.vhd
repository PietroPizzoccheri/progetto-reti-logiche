
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity MANTIX_FIXER is
  port (
    MANTIX     : in  STD_LOGIC_VECTOR(22 downto 0);
    exp        : in  STD_LOGIC_VECTOR(7 downto 0);
    MANTIX_OUT : out STD_LOGIC_VECTOR(23 downto 0)
  );
end entity;

architecture RTL of MANTIX_FIXER is

  signal EXP_IS_ZERO : STD_LOGIC;
begin

  EXP_IS_ZERO <= not(exp(0) or exp(1) or exp(2) or exp(3) or exp(4) or exp(5) or exp(6) or exp(7));

  p: process (EXP_IS_ZERO, MANTIX)
  begin
    if EXP_IS_ZERO = '1' then
      -- The mantix was DENORMALIZED
      MANTIX_OUT <= "0" & MANTIX;
    else
      -- The mantix was NORMALIZED
      MANTIX_OUT <= "1" & MANTIX;
    end if;
  end process;

end architecture;


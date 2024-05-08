
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

  -- Checks if the mantix is normalized or not, if not it normalizes it

entity MANTIX_FIXER is
  port (
    MANTIX     : in  STD_LOGIC_VECTOR(22 downto 0);
    exp        : in  STD_LOGIC_VECTOR(7 downto 0);
    MANTIX_OUT : out STD_LOGIC_VECTOR(23 downto 0); -- Returns the Significant Normalized (The mantix with a 1 in front of it)
    OFFSET     : out STD_LOGIC_VECTOR(4 downto 0)   -- Returns the offset of the mantix
  );
end entity;

architecture RTL of MANTIX_FIXER is
  component NORMALIZER is
    port (
      MANTIX  : in  STD_LOGIC_VECTOR(23 downto 0);
      SHIFTED : out STD_LOGIC_VECTOR(23 downto 0);
      OFFSET  : out STD_LOGIC_VECTOR(4 downto 0)
    );
  end component;

  signal EXP_IS_ZERO : STD_LOGIC;
  signal MANTIX_TEMP : STD_LOGIC_VECTOR(23 downto 0);
  signal OFFSET_TEMP : STD_LOGIC_VECTOR(4 downto 0);
  signal DENORMALIZED_MANTIX_TEMP : STD_LOGIC_VECTOR(23 downto 0);
begin
  EXP_IS_ZERO <= not(exp(0) or exp(1) or exp(2) or exp(3) or exp(4) or exp(5) or exp(6) or exp(7));
  DENORMALIZED_MANTIX_TEMP <= "0" & MANTIX; -- Adds a 0 in front of the mantix to make it 24 bits
  
  n: NORMALIZER
    port map (
      MANTIX  => DENORMALIZED_MANTIX_TEMP, 
      SHIFTED => MANTIX_TEMP,
      OFFSET  => OFFSET_TEMP
    );

  p: process (EXP_IS_ZERO, OFFSET_TEMP)
  begin
    if EXP_IS_ZERO = '1' then
      -- The mantix was DENORMALIZED and has been normalized
      MANTIX_OUT <= MANTIX_TEMP;
      OFFSET <= OFFSET_TEMP;
    else
      -- The mantix was already NORMALIZED
      MANTIX_OUT <= "1" & MANTIX;
      OFFSET <= "00000";
    end if;
  end process;

end architecture;


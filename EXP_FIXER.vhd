library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity EXP_FIXER is
  port (
    INTERMEDIATE_EXP    : in  STD_LOGIC_VECTOR(9 downto 0);
    INTERMEDIATE_MANTIX : in  STD_LOGIC_VECTOR(22 downto 0);
    EXP                 : out STD_LOGIC_VECTOR(7 downto 0);
    MANTIX              : out STD_LOGIC_VECTOR(22 downto 0)
  );
end entity;

architecture RTL of EXP_FIXER is

  component CLA_9 is
    port (
      X, Y : in  std_logic_vector(8 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(8 downto 0);
      Cout : out std_logic
    );
  end component;

  signal TEMP_S    : std_logic_vector(8 downto 0);
  signal TEMP_COUT : std_logic;

begin

  -- Check if the number is >= -23, if so, it is reparable otherwise is a certain underflow
  -- EXP + 23 >= 0
  underflow_check: CLA_9
    port map (
      X    => INTERMEDIATE_EXP(8 downto 0), -- Discarding the MSP becuase its just a sign extension since the minimum number we can have from the previous subtraction is -150 wich is a 9 bit number
      Y    => "000010111",
      Cin  => '0',
      S    => TEMP_S(8 downto 0),
      Cout => TEMP_COUT
    );

  -- Extend the sign bit
  -- We assume that INTERMEDIATE_EXP is a 9 bit number NEGATIVE number. otherwise TEMP_S will not be taken into account
  TEMP_S(9) <= TEMP_COUT when (INTERMEDIATE_EXP(8) = '1') and ((TEMP_S(8) = '1' and TEMP_COUT = '0') or (TEMP_S(8) = '0' and TEMP_COUT = '1')) else TEMP_S(8);

  -- Check if the exponent is overflown
  process (INTERMEDIATE_EXP)
  begin
    -- The number is positive and The exponent is larger than 254
    if (INTERMEDIATE_EXP(9) = '0') and (INTERMEDIATE_EXP(8) = '1') then
      -- It has overflowed, turn the numbre into infinity
      EXP <= "11111111";
      MANTIX <= "00000000000000000000000";
      -- If the number is negative it could possibly be an underflow
    elsif (INTERMEDIATE_EXP(9) = '1') then
      -- If TEMP_S is less than 0 (So its negative, with the MSB to 1), then its an underflow
      if (TEMP_S'high = '1') then
        -- Its a certain underflow
        EXP <= "00000000";
        MANTIX <= "00000000000000000000001";
      end if;
    else
      -- Number its ok (either a normal number or a reparable underflow)
      EXP <= INTERMEDIATE_EXP(7 downto 0);
      MANTIX <= INTERMEDIATE_MANTIX;
    end if;
  end process;
end architecture;





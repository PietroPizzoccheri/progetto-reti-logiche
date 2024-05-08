library IEEE;
  use IEEE.STD_LOGIC_1164.all;

  -- 20 ns to compute

entity RESULT_FIXER is
  port (
    INTERMEDIATE_EXP    : in  STD_LOGIC_VECTOR(9 downto 0);
    INTERMEDIATE_MANTIX : in  STD_LOGIC_VECTOR(22 downto 0);
    EXP                 : out STD_LOGIC_VECTOR(7 downto 0);
    MANTIX              : out STD_LOGIC_VECTOR(22 downto 0)
  );
end entity;

architecture RTL of RESULT_FIXER is

  component CLA_9 is
    port (
      X, Y : in  std_logic_vector(8 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(8 downto 0);
      Cout : out std_logic
    );
  end component;

  component DENORMALIZER is
    port (
      MANTIX  : in  std_logic_vector(22 downto 0);
      OFFSET  : in  std_logic_vector(4 downto 0);
      SHIFTED : out std_logic_vector(22 downto 0)
    );
  end component;

  signal TEMP_S    : std_logic_vector(9 downto 0);
  signal TEMP_COUT : std_logic;

  signal DENORM_OFFSET_SIG : std_logic_vector(4 downto 0);

  signal MANTIX_DENORM : std_logic_vector(22 downto 0);

begin

  -- Check if the number is >= -22, if so, it is reparable otherwise is a certain underflow
  -- EXP + 22 >= 0
  underflow_check: CLA_9
    port map (
      X    => INTERMEDIATE_EXP(8 downto 0), -- Discarding the MSP becuase its just a sign extension since the minimum number we can have from the previous subtraction is -150 wich is a 9 bit number
      Y    => "000010110",
      Cin  => '0',
      S    => TEMP_S(8 downto 0),           -- somma fra esponente e 22
      Cout => TEMP_COUT
    );

  denorm: DENORMALIZER
    port map (
      MANTIX  => INTERMEDIATE_MANTIX,
      OFFSET  => DENORM_OFFSET_SIG,
      SHIFTED => MANTIX_DENORM
    );

  -- Extend the sign bit
  -- We assume that INTERMEDIATE_EXP is a 9 bit number NEGATIVE number. otherwise TEMP_S will not be taken into account
  DENORM_OFFSET_SIG <= TEMP_S(4 downto 0);
  TEMP_S(9)         <= TEMP_COUT when ((INTERMEDIATE_EXP(8) = '0')) and ((TEMP_S(8) = '1' and TEMP_COUT = '0') or (TEMP_S(8) = '0' and TEMP_COUT = '1')) else TEMP_S(8);

  -- Check if the exponent is overflown
  process (INTERMEDIATE_EXP, TEMP_S, DENORM_OFFSET_SIG)
  begin
    -- The number is positive and The exponent is larger than 254
    if (INTERMEDIATE_EXP(9) = '0') and (INTERMEDIATE_EXP(8) = '1') then
      -- It has overflowed, turn the numbre into infinity
      EXP <= "11111111";
      MANTIX <= "00000000000000000000000";
      -- If the number is negative it could possibly be an underflow
    elsif (INTERMEDIATE_EXP(9) = '1') then
      -- If TEMP_S is less than 0 (So its negative, with the MSB to 1), then its an underflow
      if (TEMP_S(9) = '1') then
        -- Its a certain underflow
        EXP <= "00000000";
        MANTIX <= "00000000000000000000000";
      else
        EXP <= "00000000"; -- denormalized number (so we set the exp to zero)
        MANTIX <= MANTIX_DENORM; -- da shiftare a dx di temp_s(ultimi 5 bit di temp_s in realtà) posizioni
      end if;
    else
      -- Number its ok (either a normal number)
      EXP <= INTERMEDIATE_EXP(7 downto 0);
      MANTIX <= INTERMEDIATE_MANTIX;
    end if;
  end process;
end architecture;





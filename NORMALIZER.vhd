library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity NORMALIZER is
  port (
    MANTIX            : in  STD_LOGIC_VECTOR(22 downto 0);
    CLK               : in  STD_LOGIC;
    RESET             : in  STD_LOGIC;
    BIAS_EXIT         : out STD_LOGIC_VECTOR(4 downto 0);
    MANTIX_NORMALIZED : out STD_LOGIC_VECTOR(22 downto 0)
  );
end entity;

architecture RTL of NORMALIZER is

  component SHIFTER is
    port (
      CLK     : in  STD_LOGIC;
      RESET   : in  STD_LOGIC;
      MANTIX  : in  STD_LOGIC_VECTOR(22 downto 0);
      SHIFTED : out STD_LOGIC_VECTOR(22 downto 0)
    );
  end component;

  component COUNTER_MOD_23 is
    port (CLK   : in  std_logic;
          RESET : in  std_logic;
          Y     : out std_logic_vector(4 downto 0)
         );
  end component;

  signal BIAS_TEMP      : STD_LOGIC_VECTOR(4 downto 0);
  signal MSB_CHECK      : STD_LOGIC := '0';
  signal MANTIX_TEMP    : STD_LOGIC_VECTOR(22 downto 0);
  signal HAS_NORMALIZED : STD_LOGIC := '0';

begin

  -- Sync Reset
  -- rst: process (CLK, RESET)
  -- begin
  --   if (CLK'event and CLK = '1') then
  --     if RESET = '1' then
  --       BIAS_TEMP <= (others => 'U');
  --       MSB_CHECK <= '0';
  --       MANTIX_TEMP <= (others => 'U');
  --       HAS_NORMALIZED <= '0';
  --     end if;
  --   end if;
  -- end process;
  -- Generate MSB_CHECK based on the most significant bit of MANTIX_TEMP
  process (CLK, MANTIX_TEMP)
  begin
    if (CLK'event and CLK = '1') then
      if MANTIX_TEMP(22) = '1' and MSB_CHECK = '0' then
        MSB_CHECK <= '1';
      end if;
    end if;
  end process;

  process (CLK, MSB_CHECK, BIAS_TEMP)
  begin
    if (CLK'event and CLK = '1') then
      if MSB_CHECK = '1' and HAS_NORMALIZED = '0' then
        HAS_NORMALIZED <= '1';
        -- The clock after the MSB is set assigns the bias and mantix
        BIAS_EXIT <= BIAS_TEMP;
        MANTIX_NORMALIZED <= MANTIX_TEMP;
      end if;
    end if;
  end process;

  -- Shift the mantissa based on the clock signal
  SHIFTER0: SHIFTER
    port map (
      CLK     => CLK,
      RESET   => RESET,
      MANTIX  => MANTIX,
      SHIFTED => MANTIX_TEMP
    );

  -- Generate bias based on the clock signal
  COUNTER: COUNTER_MOD_23
    port map (
      CLK   => CLK,
      RESET => RESET,
      Y     => BIAS_TEMP
    );
end architecture;

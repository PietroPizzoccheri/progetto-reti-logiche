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
  process (CLK, RESET)
  begin
    -- Async reset
    if (RESET = '1') then
      MSB_CHECK <= '0';
      HAS_NORMALIZED <= '0';
      BIAS_EXIT <= (others => 'U');
      MANTIX_NORMALIZED <= (others => 'U');
    elsif (CLK'event and CLK = '1') then
      -- When we receive a 1 in the MSB we need to wait one more clock cycle
      -- We also need to check the case when the MSB is 1 in the first cycle MANTIX(MANTIX'high) = '1'
      if (MANTIX_TEMP(MANTIX_TEMP'high) = '1' or MANTIX(MANTIX'high) = '1') and MSB_CHECK = '0' then
        MSB_CHECK <= '1';
        -- The cycle after we receive the MSB we have the normalized mantissa and bias
      elsif MSB_CHECK = '1' and HAS_NORMALIZED = '0' then
        HAS_NORMALIZED <= '1';
        BIAS_EXIT <= BIAS_TEMP;
        MANTIX_NORMALIZED <= MANTIX_TEMP;
      end if;
    end if;
  end process;

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

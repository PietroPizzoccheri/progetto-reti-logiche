library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity NORMALIZER is
  port (
    MANTIX            : in  STD_LOGIC_VECTOR(22 downto 0);
    Clock             : in  STD_LOGIC;
    BIAS_EXIT         : out STD_LOGIC_VECTOR(4 downto 0);
    MANTIX_NORMALIZED : out STD_LOGIC_VECTOR(22 downto 0)
  );
end entity;

architecture RTL of NORMALIZER is

  component SHIFTER is
    port (
      CLK     : in  STD_LOGIC;
      MANTIX  : in  STD_LOGIC_VECTOR(22 downto 0);
      SHIFTED : out STD_LOGIC_VECTOR(22 downto 0)
    );
  end component;

  component FFD_23 is
    port (
      CLK : in  STD_LOGIC;
      D   : in  std_logic_vector(22 downto 0);
      Q   : out std_logic_vector(22 downto 0)
    );
  end component;

  component FFD_5 is
    port (
      CLK : in  STD_LOGIC;
      D   : in  std_logic_vector(4 downto 0);
      Q   : out std_logic_vector(4 downto 0)
    );
  end component;



  component COUNTER_MOD_23 is
    port (CLK   : in  std_logic;
          RESET : in  std_logic;
          Y     : out std_logic_vector(4 downto 0)
         );
  end component;

  component MUX_23_1 is
    port (
      A : in  STD_LOGIC_VECTOR(22 downto 0);
      B : in  STD_LOGIC_VECTOR(22 downto 0);
      S : in  STD_LOGIC;
      Y : out STD_LOGIC_VECTOR(22 downto 0)
    );
  end component;

  component MUX_5_1 is
    port (
      A : in  STD_LOGIC_VECTOR(4 downto 0);
      B : in  STD_LOGIC_VECTOR(4 downto 0);
      S : in  STD_LOGIC;
      Y : out STD_LOGIC_VECTOR(4 downto 0)
    );
  end component;

  signal bias            : STD_LOGIC_VECTOR(4 downto 0);
  signal bias_post_mux   : STD_LOGIC_VECTOR(4 downto 0);
  signal MANTIX_SIGNAL   : STD_LOGIC_VECTOR(22 downto 0);
  signal MANTIX_POST_MUX : STD_LOGIC_VECTOR(22 downto 0);
  signal MSB_CHECK      : STD_LOGIC;

begin

  MANTIX_SIGNAL <= MANTIX;
  MSB_CHECK <= Clock and (not MANTIX(22));
  SHIFTER0: SHIFTER
    port map (
      CLK     => Clock,
      MANTIX  => MANTIX_SIGNAL,
      SHIFTED => MANTIX_SIGNAL
    );

  COUNTER: COUNTER_MOD_23
    port map (
      CLK   => Clock,
      RESET => '0',
      Y     => bias
    );

  FFD_BIAS: FFD_5
    port map (
      CLK    => Clock,
      D => bias_post_mux,
      Q => BIAS_EXIT
    );

  FFD_MANTIX: FFD_23
    port map (
      CLK      => Clock,
      D => MANTIX_POST_MUX,
      Q => MANTIX_NORMALIZED
    );

  MUX_MANTIX: MUX_23_1
    port map (
      A => "00000000000000000000000",
      B => MANTIX_SIGNAL,
      S => MSB_CHECK,
      Y => MANTIX_POST_MUX
    );

  MUX_BIAS: MUX_5_1
    port map (
      A => "00000",
      B => bias,
      S => MSB_CHECK,
      Y => bias_post_mux
    );

end architecture;

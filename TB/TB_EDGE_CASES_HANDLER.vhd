library ieee;
  use ieee.std_logic_1164.all;

entity TB_EDGE_CASES_HANDLER is
end entity;

architecture behavior of TB_EDGE_CASES_HANDLER is

  -- Component Declaration for the Unit Under Test (UUT)
  component EDGE_CASES_HANDLER
    port (
      X       : in  std_logic_vector(31 downto 0);
      Y       : in  std_logic_vector(31 downto 0);
      zero    : out std_logic;
      invalid : out std_logic;
      inf     : out std_logic
    );
  end component;

  --Inputs
  signal X : std_logic_vector(31 downto 0) := (others => '0');
  signal Y : std_logic_vector(31 downto 0) := (others => '0');

  --Outputs
  signal zero    : std_logic;
  signal invalid : std_logic;
  signal inf     : std_logic;

  --Values
  constant norm_v   : std_logic_vector(31 downto 0) := "01000000000000000000000000000000";
  constant nan_v    : std_logic_vector(31 downto 0) := "01111111100011110000000001000000";
  constant denorm_v : std_logic_vector(31 downto 0) := "00000000010011001100110011001101";
  constant inf_v    : std_logic_vector(31 downto 0) := "01111111100000000000000000000000";
  constant zero_v   : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
begin

  -- Instantiate the Unit Under Test (UUT)
  uut: EDGE_CASES_HANDLER
    port map (
      X       => X,
      Y       => Y,
      zero    => zero,
      invalid => invalid,
      inf     => inf
    );

  -- Stimulus process
  process
  begin
    -- Stimulus for X = 0, Y = 0
    X <= zero_v;
    Y <= zero_v;
    wait for 20 ns;

    -- Stimulus for X = 0, Y = norm
    X <= zero_v;
    Y <= norm_v;
    wait for 20 ns;

    -- Stimulus for X = norm, Y = 0
    X <= norm_v;
    Y <= zero_v;
    wait for 20 ns;

    -- Stimulus for X = 0, Y = nan
    X <= zero_v;
    Y <= nan_v;
    wait for 20 ns;

    -- Stimulus for X = 0, Y = inf
    X <= zero_v;
    Y <= inf_v;
    wait for 20 ns;

    -- Stimulus for X = inf, Y = 0
    X <= inf_v;
    Y <= zero_v;
    wait for 20 ns;

    -- Stimulus for X = inf, Y = inf
    X <= inf_v;
    Y <= inf_v;
    wait for 20 ns;

    -- Stimulus for X = inf, Y = norm
    X <= inf_v;
    Y <= norm_v;
    wait for 20 ns;

    -- Stimulus for X = norm, Y = inf
    X <= norm_v;
    Y <= inf_v;
    wait for 20 ns;

    -- Stimulus for X = nan, Y = 0
    X <= nan_v;
    Y <= zero_v;
    wait for 20 ns;

    -- Stimulus for X = nan, Y = nan
    X <= nan_v;
    Y <= nan_v;
    wait for 20 ns;

    -- Stimulus for X = nan, Y = inf
    X <= nan_v;
    Y <= inf_v;
    wait for 20 ns;

    -- Stimulus for X = inf, Y = nan
    X <= inf_v;
    Y <= nan_v;
    wait for 20 ns;

    -- Stimulus for X = nan, Y = norm
    X <= nan_v;
    Y <= norm_v;
    wait for 20 ns;

    -- Stimulus for X = norm, Y = nan
    X <= norm_v;
    Y <= nan_v;
    wait for 20 ns;

    -- Stimulus for X = denorm, Y = denorm
    X <= denorm_v;
    Y <= denorm_v;
    wait for 20 ns;

    -- Stimulus for X = denorm, Y = norm
    X <= denorm_v;
    Y <= norm_v;
    wait for 20 ns;

    -- Stimulus for X = norm, Y = denorm
    X <= norm_v;
    Y <= denorm_v;
    wait for 20 ns;

    -- Stimulus for X = denorm, Y = inf
    X <= denorm_v;
    Y <= inf_v;
    wait for 20 ns;

    -- Stimulus for X = inf, Y = denorm
    X <= inf_v;
    Y <= denorm_v;
    wait for 20 ns;

    -- Stimulus for X = denorm, Y = nan
    X <= denorm_v;
    Y <= nan_v;
    wait for 20 ns;

    -- Stimulus for X = nan, Y = denorm
    X <= nan_v;
    Y <= denorm_v;
    wait for 20 ns;

    -- Stimulus for X = denorm, Y = zero
    X <= denorm_v;
    Y <= zero_v;
    wait for 20 ns;

    -- Stimulus for X = zero, Y = denorm
    X <= zero_v;
    Y <= denorm_v;
    wait;
  end process;
end architecture;

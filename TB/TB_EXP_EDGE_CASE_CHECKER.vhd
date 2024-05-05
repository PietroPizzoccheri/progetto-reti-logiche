library ieee;
  use ieee.std_logic_1164.all;

entity TB_FLAG_SETTER is
end entity;

architecture behavior of TB_FLAG_SETTER is

  -- Component Declaration for the Unit Under Test (UUT)
  component FLAG_SETTER is
    port (
      exp    : in  std_logic_vector(7 downto 0);
      mantix : in  std_logic_vector(22 downto 0);
      zero   : out std_logic;
      norm   : out std_logic;
      denorm : out std_logic;
      nan    : out std_logic;
      inf    : out std_logic
    );
  end component;

  --Inputs
  signal exp    : std_logic_vector(7 downto 0);
  signal mantix : std_logic_vector(22 downto 0);
  --Outputs
  signal zero   : std_logic;
  signal norm   : std_logic;
  signal denorm : std_logic;
  signal nan    : std_logic;
  signal inf    : std_logic;
begin

  -- Instantiate the Unit Under Test (UUT)
  uut: FLAG_SETTER
    port map (
      exp    => exp,
      mantix => mantix,
      zero   => zero,
      norm   => norm,
      denorm => denorm,
      nan    => nan,
      inf    => inf
    );

  -- Stimulus process
  process
  begin
    -- We expect this to set zero to 1 (and others to 0)
    exp <= "00000000";
    mantix <= "00000000000000000000000";
    wait for 20 ns;

    -- We expect this to set norm to 1 (and others to 0)
    exp <= "00001000";
    mantix <= "00000000000000000000011";
    wait for 20 ns;

    -- We expect this to set denorm to 1 (and others to 0)
    exp <= "00000000";
    mantix <= "00000000000000000000001";
    wait for 20 ns;

    -- We expect this to set nan to 1 (and others to 0)
    exp <= "11111111";
    mantix <= "10000000000000000000000";
    wait for 20 ns;

    -- We expect this to set inf to 1 (and others to 0)
    exp <= "11111111";
    mantix <= "00000000000000000000000";
    wait;

  end process;

end architecture;

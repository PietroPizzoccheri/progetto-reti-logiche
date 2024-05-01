library ieee;
  use ieee.std_logic_1164.all;

  -- Uncomment the following library declaration if using
  -- arithmetic functions with Signed or Unsigned values
  --USE ieee.numeric_std.ALL;

entity TB_CLA_MUL_23 is
end entity;

architecture behavior of TB_CLA_MUL_23 is

  -- Component Declaration for the Unit Under Test (UUT)
  component CLA_MUL_23
    port (
      X : in  std_logic_vector(22 downto 0);
      Y : in  std_logic_vector(22 downto 0);
      P : out std_logic_vector(45 downto 0)
    );
  end component;

  --Inputs
  signal X : std_logic_vector(22 downto 0) := (others => '0');
  signal Y : std_logic_vector(22 downto 0) := (others => '0');

  --Outputs
  signal P          : std_logic_vector(45 downto 0);
  signal EXPECTED_P : std_logic_vector(45 downto 0);
begin

  -- Instantiate the Unit Under Test (UUT)
  uut: CLA_MUL_23
    port map (
      X => X,
      Y => Y,
      P => P
    );

  -- Stimulus process

  stim_proc: process
  begin
    X <= "00000000000000000000010";
    Y <= "00000000000000000000010";
    EXPECTED_P <= "0000000000000000000000000000000000000000000100";
    wait for 50 ns;
    assert (P = EXPECTED_P) report "Test 1 failed" severity error;

    X <= "11111111111000000000000";
    Y <= "11111111111000000000000";
    EXPECTED_P <= "0111111111100000000000100000000000000000000000";
    wait for 50 ns;
    assert (P = EXPECTED_P) report "Test 2 failed" severity error;

    X <= "00000000000000000000111";
    Y <= "00000000000000000000111";
    EXPECTED_P <= "0000000000000000000000000000000000000000110001";
    wait for 50 ns;
    assert (P = EXPECTED_P) report "Test 3 failed" severity error;

    wait;
  end process;

end architecture;

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
  signal P : std_logic_vector(45 downto 0);
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
    -- insert stimulus here 
    X <= "00000000000000000000010";
    Y <= "00000000000000000000010";
    assert (P = "000000000000000000000100") report "Test 1 failed" severity error;
    wait for 100 ns;

    X <= "00000000000000000000100";
    Y <= "00000000000000000000100";
    assert (P = "000000000000000000010000") report "Test 2 failed" severity error;
    wait;

  end process;

end architecture;

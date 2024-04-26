
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity COUNTER_MOD_23 is
  port (CLK   : in  std_logic;
        RESET : in  std_logic;
        Y     : out std_logic_vector(4 downto 0)
       );
end entity;

architecture rtl of COUNTER_MOD_23 is
  component CLA_5 is
    port (
      X, Y : in  std_logic_vector(5 - 1 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(5 - 1 downto 0);
      Cout : out std_logic
    );
  end component;

  signal Counter    : std_logic_vector(4 downto 0) := "00000";
  signal NextNumber : std_logic_vector(4 downto 0);

begin
  -- 5-bit CLA adder to add 1 to the counter
  ADDER: CLA_5
    port map (
      X    => Counter,
      Y    => "00001",
      S    => NextNumber,
      Cin  => '0',
      Cout => open
    );

  count: process (CLK, RESET)
  begin
    if (RESET = '1') then
      Counter <= "00000";
    elsif (CLK'event and CLK = '1') then
      -- When the counter reaches 23, it resets to 0
      if (NextNumber = "11000") then
        Counter <= "00000";
      else
        Counter <= NextNumber;
      end if;
    end if;
  end process;

  -- Assigns the output signal
  Y <= Counter;
end architecture;

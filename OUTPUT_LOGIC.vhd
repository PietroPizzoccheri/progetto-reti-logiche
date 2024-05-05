library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity OUTPUT_LOGIC is
  port (
    result_in          : in  std_logic_vector(31 downto 0);
    zero               : in  std_logic;
    invalid_in         : in  std_logic;
    inf                : in  std_logic;
    overflow_underflow : in  std_logic;
    result_out         : out std_logic_vector(31 downto 0);
    invalid_out        : out std_logic
  );
end entity;

architecture rtl of OUTPUT_LOGIC is
  constant UnsignedInfinity : std_logic_vector(30 downto 0) := "1111111100000000000000000000000";
begin

  rl: process (result_in, zero, inf, invalid_in, overflow_underflow)
  begin
    invalid_out <= '0';
    if invalid_in = '1' or overflow_underflow = '1' then
      result_out <= (others => '-');
      invalid_out <= '1';
    elsif zero = '1' then
      result_out <= (others => '0');
    elsif inf = '1' then
      -- Add the sign bit to the infinity
      result_out <= result_in(31) & UnsignedInfinity;
    else
      result_out <= result_in;
    end if;
  end process;
end architecture;

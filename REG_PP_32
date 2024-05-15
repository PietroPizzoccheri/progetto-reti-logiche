library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity REG_PP_32 is
  port (
    CLK : in  std_logic;
    RST : in  std_logic;
    X   : in  std_logic_vector(31 downto 0);
    Y   : out std_logic_vector(31 downto 0)
  );
end entity;

architecture rtl of REG_PP_32 is
begin
  reg: process (CLK, RST)
  begin
    if (RST = '1') then
      Y <= (others => '0');
    elsif (rising_edge(CLK)) then
      Y <= X;
    end if;
  end process;
end architecture;

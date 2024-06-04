library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity REG_PP_N is
  generic (
    N : integer := 1
  );
  port (
    CLK : in  std_logic;
    RST : in  std_logic;
    X   : in  std_logic_vector(N - 1 downto 0);
    Y   : out std_logic_vector(N - 1 downto 0)
  );
end entity;

architecture rtl of REG_PP_N is
begin
  reg: process (CLK, RST)
  begin
    if (RST = '1') then
      Y <= (others => '0');
    elsif (CLK'event and CLK = '1') then
      Y <= X;
    end if;
  end process;
end architecture;

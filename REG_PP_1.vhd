library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity REG_PP_1 is
  port (CLK : in  std_logic;
        RST : in  std_logic;
        X   : in  std_logic;
        Y   : out std_logic
       );
end entity;

architecture rtl of REG_PP_1 is
begin
  reg: process (CLK, RST)
  begin
    if (RST = '1') then
      Y <= '0';
    elsif (rising_edge(CLK)) then
      Y <= X;
    end if;
  end process;
end architecture;

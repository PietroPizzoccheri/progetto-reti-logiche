
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity DECODER_2_4 is
  port (A : in  STD_LOGIC_VECTOR(1 downto 0);
        Y : out STD_LOGIC_VECTOR(3 downto 0));
end entity;

architecture RTL of DECODER_2_4 is
begin
  with a select
    Y <= "0001" when "00",
         "0010" when "01",
         "0100" when "10",
         "1000" when "11",
         "----" when others;

end RTL;


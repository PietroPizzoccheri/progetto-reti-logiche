library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity DENORMALIZER is
  port (
    MANTIX  : in  STD_LOGIC_VECTOR(22 downto 0);
    OFFSET  : in  STD_LOGIC_VECTOR(4 downto 0);
    SHIFTED : out STD_LOGIC_VECTOR(22 downto 0)
  );
end entity;

architecture RTL of DENORMALIZER is

begin

  with OFFSET select
    SHIFTED <= "0000000000000000000001" & MANTIX(0)               when "00000",
               "000000000000000000001" & MANTIX(22 downto 21 + 0) when "00001",
               "00000000000000000001" & MANTIX(22 downto 20 + 0)  when "00010",
               "0000000000000000001" & MANTIX(22 downto 19 + 0)   when "00011",
               "000000000000000001" & MANTIX(22 downto 18 + 0)    when "00100",
               "00000000000000001" & MANTIX(22 downto 17 + 0)     when "00101",
               "0000000000000001" & MANTIX(22 downto 16 + 0)      when "00110",
               "000000000000001" & MANTIX(22 downto 15 + 0)       when "00111",
               "00000000000001" & MANTIX(22 downto 14 + 0)        when "01000",
               "0000000000001" & MANTIX(22 downto 13 + 0)         when "01001",
               "000000000001" & MANTIX(22 downto 12 + 0)          when "01010",
               "00000000001" & MANTIX(22 downto 11 + 0)           when "01011",
               "0000000001" & MANTIX(22 downto 10 + 0)            when "01100",
               "000000001" & MANTIX(22 downto 9 + 0)              when "01101",
               "00000001" & MANTIX(22 downto 8 + 0)               when "01110",
               "0000001" & MANTIX(22 downto 7 + 0)                when "01111",
               "000001" & MANTIX(22 downto 6 + 0)                 when "10000",
               "00001" & MANTIX(22 downto 5 + 0)                  when "10001",
               "0001" & MANTIX(22 downto 4 + 0)                   when "10010",
               "001" & MANTIX(22 downto 3 + 0)                    when "10011",
               "01" & MANTIX(22 downto 2 + 0)                     when "10100",
               "1" & MANTIX(22 downto 1 + 0)                      when "10101",
               MANTIX(22 downto 0)                                when "10110",
               "00000000000000000000000"                          when others;

end architecture;


library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity SHIFTER is
  port (
    MANTIX  : in  STD_LOGIC_VECTOR(23 downto 0);
    SHIFTED : out STD_LOGIC_VECTOR(23 downto 0);
    OFFSET  : out STD_LOGIC_VECTOR(4 downto 0)
  );
end entity;

architecture RTL of SHIFTER is
  component OFFSET_ENCODER is
    port (
      X : in  std_logic_vector(23 downto 0); -- The input vector (The 24bit Mantix)
      Y : out std_logic_vector(4 downto 0);  -- The Offset value
      Z : out std_logic                      -- Error signal if there are no 1s
    );
  end component;

  signal OFFSET_SIG : std_logic_vector(4 downto 0);

begin

  encoder: OFFSET_ENCODER 
  port map (
    MANTIX, 
    OFFSET_SIG, 
    open
    );

  with OFFSET_SIG select
    SHIFTED <= MANTIX                                              when "00000",
               MANTIX(23 - 1 downto 0) & "0"                       when "00001",
               MANTIX(23 - 2 downto 0) & "00"                      when "00010",
               MANTIX(23 - 3 downto 0) & "000"                     when "00011",
               MANTIX(23 - 4 downto 0) & "0000"                    when "00100",
               MANTIX(23 - 5 downto 0) & "00000"                   when "00101",
               MANTIX(23 - 6 downto 0) & "000000"                  when "00110",
               MANTIX(23 - 7 downto 0) & "0000000"                 when "00111",
               MANTIX(23 - 8 downto 0) & "00000000"                when "01000",
               MANTIX(23 - 9 downto 0) & "000000000"               when "01001",
               MANTIX(23 - 10 downto 0) & "0000000000"             when "01010",
               MANTIX(23 - 11 downto 0) & "00000000000"            when "01011",
               MANTIX(23 - 12 downto 0) & "000000000000"           when "01100",
               MANTIX(23 - 13 downto 0) & "0000000000000"          when "01101",
               MANTIX(23 - 14 downto 0) & "00000000000000"         when "01110",
               MANTIX(23 - 15 downto 0) & "000000000000000"        when "01111",
               MANTIX(23 - 16 downto 0) & "0000000000000000"       when "10000",
               MANTIX(23 - 17 downto 0) & "00000000000000000"      when "10001",
               MANTIX(23 - 18 downto 0) & "000000000000000000"     when "10010",
               MANTIX(23 - 19 downto 0) & "0000000000000000000"    when "10011",
               MANTIX(23 - 20 downto 0) & "00000000000000000000"   when "10100",
               MANTIX(23 - 21 downto 0) & "000000000000000000000"  when "10101",
               MANTIX(23 - 22 downto 0) & "0000000000000000000000" when "10110",
               MANTIX(0) & "00000000000000000000000"               when "10111",
               "000000000000000000000000"                          when others;

OFFSET <= OFFSET_SIG;

end architecture RTL;


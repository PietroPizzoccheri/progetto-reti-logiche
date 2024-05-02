library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity OFFSET_ENCODER is
  port (
    X : in  std_logic_vector(22 downto 0); -- The input vector (The 23bit Mantix)
    Y : out std_logic_vector(4 downto 0);  -- The Offset value
    Z : out std_logic                      -- Error signal if there are no 1s
  );
end entity;

-- OFFSET_ENCODER is a Priority Encoder, reversed and with an offset of 1

architecture rtl of OFFSET_ENCODER is
  signal TEMP : std_logic_vector(5 downto 0);
begin
  with X select
    TEMP <= "-----1" when "00000000000000000000000",
            "101110" when "00000000000000000000001",
            "101100" when "0000000000000000000001-",
            "101010" when "000000000000000000001--",
            "101000" when "00000000000000000001---",
            "100110" when "0000000000000000001----",
            "100100" when "000000000000000001-----",
            "100010" when "00000000000000001------",
            "100000" when "0000000000000001-------",
            "011110" when "000000000000001--------",
            "011100" when "00000000000001---------",
            "011010" when "0000000000001----------",
            "011000" when "000000000001-----------",
            "010110" when "00000000001------------",
            "010100" when "0000000001-------------",
            "010010" when "000000001--------------",
            "010000" when "00000001---------------",
            "001110" when "0000001----------------",
            "001100" when "000001-----------------",
            "001010" when "00001------------------",
            "001000" when "0001-------------------",
            "000110" when "001--------------------",
            "000100" when "01---------------------",
            "000010" when "1----------------------",
            "------" when others;

  Y <= TEMP(5 downto 1);
  Z <= TEMP(0);

end architecture;



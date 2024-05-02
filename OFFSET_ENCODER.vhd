library IEEE;
  use IEEE.STD_LOGIC_1164.all;

-- 20 ns to compute


entity OFFSET_ENCODER is
  port (
    X : in  std_logic_vector(23 downto 0); -- The input vector (The 24bit Mantix)
    Y : out std_logic_vector(4 downto 0);  -- The Offset value
    Z : out std_logic                      -- Error signal if there are no 1s
  );
end entity;

-- OFFSET_ENCODER is a Priority Encoder, reversed and with an offset of 1
-- architecture rtl of OFFSET_ENCODER is
--   signal TEMP : std_logic_vector(5 downto 0);
-- begin
--   with X select
--     TEMP <= "-----1" when "00000000000000000000000",
--             "101110" when "00000000000000000000001",
--             "101100" when "0000000000000000000001-",
--             "101010" when "000000000000000000001--",
--             "101000" when "00000000000000000001---",
--             "100110" when "0000000000000000001----",
--             "100100" when "000000000000000001-----",
--             "100010" when "00000000000000001------",
--             "100000" when "0000000000000001-------",
--             "011110" when "000000000000001--------",
--             "011100" when "00000000000001---------",
--             "011010" when "0000000000001----------",
--             "011000" when "000000000001-----------",
--             "010110" when "00000000001------------",
--             "010100" when "0000000001-------------",
--             "010010" when "000000001--------------",
--             "010000" when "00000001---------------",
--             "001110" when "0000001----------------",
--             "001100" when "000001-----------------",
--             "001010" when "00001------------------",
--             "001000" when "0001-------------------",
--             "000110" when "001--------------------",
--             "000100" when "01---------------------",
--             "000010" when "1----------------------",
--             "------" when others;
--   Y <= TEMP(5 downto 1);
--   Z <= TEMP(0);
-- end architecture;
-- Seems like until VHDL 2008, the select statement does not support the use of don't care values
-- And in Xilinx ISE VHDL 2008 is not supported

architecture rtl of OFFSET_ENCODER is
begin
  process (X)
  begin
    Z <= '0';
    if X(23) = '1' then
      Y <= "00001";
    elsif X(22) = '1' and X(23) = '0' then
      Y <= "00010";
    elsif X(21) = '1' and X(22) = '0' and X(23) = '0' then
      Y <= "00011";
    elsif X(20) = '1' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "00100";
    elsif X(19) = '1' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "00101";
    elsif X(18) = '1' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "00110";
    elsif X(17) = '1' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "00111";
    elsif X(16) = '1' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "01000";
    elsif X(15) = '1' and X(16) = '0' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "01001";
    elsif X(14) = '1' and X(15) = '0' and X(16) = '0' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "01010";
    elsif X(13) = '1' and X(14) = '0' and X(15) = '0' and X(16) = '0' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "01011";
    elsif X(12) = '1' and X(13) = '0' and X(14) = '0' and X(15) = '0' and X(16) = '0' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "01100";
    elsif X(11) = '1' and X(12) = '0' and X(13) = '0' and X(14) = '0' and X(15) = '0' and X(16) = '0' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "01101";
    elsif X(10) = '1' and X(11) = '0' and X(12) = '0' and X(13) = '0' and X(14) = '0' and X(15) = '0' and X(16) = '0' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "01110";
    elsif X(9) = '1' and X(10) = '0' and X(11) = '0' and X(12) = '0' and X(13) = '0' and X(14) = '0' and X(15) = '0' and X(16) = '0' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "01111";
    elsif X(8) = '1' and X(9) = '0' and X(10) = '0' and X(11) = '0' and X(12) = '0' and X(13) = '0' and X(14) = '0' and X(15) = '0' and X(16) = '0' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "10000";
    elsif X(7) = '1' and X(8) = '0' and X(9) = '0' and X(10) = '0' and X(11) = '0' and X(12) = '0' and X(13) = '0' and X(14) = '0' and X(15) = '0' and X(16) = '0' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "10001";
    elsif X(6) = '1' and X(7) = '0' and X(8) = '0' and X(9) = '0' and X(10) = '0' and X(11) = '0' and X(12) = '0' and X(13) = '0' and X(14) = '0' and X(15) = '0' and X(16) = '0' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "10010";
    elsif X(5) = '1' and X(6) = '0' and X(7) = '0' and X(8) = '0' and X(9) = '0' and X(10) = '0' and X(11) = '0' and X(12) = '0' and X(13) = '0' and X(14) = '0' and X(15) = '0' and X(16) = '0' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "10011";
    elsif X(4) = '1' and X(5) = '0' and X(6) = '0' and X(7) = '0' and X(8) = '0' and X(9) = '0' and X(10) = '0' and X(11) = '0' and X(12) = '0' and X(13) = '0' and X(14) = '0' and X(15) = '0' and X(16) = '0' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "10100";
    elsif X(3) = '1' and X(4) = '0' and X(5) = '0' and X(6) = '0' and X(7) = '0' and X(8) = '0' and X(9) = '0' and X(10) = '0' and X(11) = '0' and X(12) = '0' and X(13) = '0' and X(14) = '0' and X(15) = '0' and X(16) = '0' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "10101";
    elsif X(2) = '1' and X(3) = '0' and X(4) = '0' and X(5) = '0' and X(6) = '0' and X(7) = '0' and X(8) = '0' and X(9) = '0' and X(10) = '0' and X(11) = '0' and X(12) = '0' and X(13) = '0' and X(14) = '0' and X(15) = '0' and X(16) = '0' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "10110";
    elsif X(1) = '1' and X(2) = '0' and X(3) = '0' and X(4) = '0' and X(5) = '0' and X(6) = '0' and X(7) = '0' and X(8) = '0' and X(9) = '0' and X(10) = '0' and X(11) = '0' and X(12) = '0' and X(13) = '0' and X(14) = '0' and X(15) = '0' and X(16) = '0' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "10111";
    elsif X(0) = '1' and X(1) = '0' and X(2) = '0' and X(3) = '0' and X(4) = '0' and X(5) = '0' and X(6) = '0' and X(7) = '0' and X(8) = '0' and X(9) = '0' and X(10) = '0' and X(11) = '0' and X(12) = '0' and X(13) = '0' and X(14) = '0' and X(15) = '0' and X(16) = '0' and X(17) = '0' and X(18) = '0' and X(19) = '0' and X(20) = '0' and X(21) = '0' and X(22) = '0' and X(23) = '0' then
      Y <= "11000";
    else
      Y <= "-----";
      Z <= '1';
    end if;
  end process;
end architecture;

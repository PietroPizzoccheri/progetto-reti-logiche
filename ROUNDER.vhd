library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity ROUNDER is
  port (
    MANTIX  : in  STD_LOGIC_VECTOR(47 downto 0);
    SHIFTED : out STD_LOGIC_VECTOR(22 downto 0);
    OFFSET  : out STD_LOGIC_VECTOR(4 downto 0);
    SUB     : out STD_LOGIC -- Indicate if we want to subtract the offset
  );
end entity;

-- 25 ns to compute

architecture RTL of ROUNDER is
  component OFFSET_ENCODER is
    port (
      X : in  std_logic_vector(23 downto 0);
      Y : out std_logic_vector(4 downto 0);
      Z : out std_logic
    );
  end component;

  signal OFFSET_SIG   : std_logic_vector(4 downto 0);
  signal ALL_ZEROS    : std_logic;
  signal SHIFTED_TEMP : std_logic_vector(22 downto 0);
begin
  encoder: OFFSET_ENCODER
    port map (
      MANTIX(45 downto 22),
      OFFSET_SIG,
      ALL_ZEROS
    );

  -- Otherwise, we will need to subtract from the exponent
  with OFFSET_SIG select
    SHIFTED_TEMP <= MANTIX(45 - 1 downto 23 - 1)   when "00001",
                    MANTIX(45 - 2 downto 23 - 2)   when "00010",
                    MANTIX(45 - 3 downto 23 - 3)   when "00011",
                    MANTIX(45 - 4 downto 23 - 4)   when "00100",
                    MANTIX(45 - 5 downto 23 - 5)   when "00101",
                    MANTIX(45 - 6 downto 23 - 6)   when "00110",
                    MANTIX(45 - 7 downto 23 - 7)   when "00111",
                    MANTIX(45 - 8 downto 23 - 8)   when "01000",
                    MANTIX(45 - 9 downto 23 - 9)   when "01001",
                    MANTIX(45 - 10 downto 23 - 10) when "01010",
                    MANTIX(45 - 11 downto 23 - 11) when "01011",
                    MANTIX(45 - 12 downto 23 - 12) when "01100",
                    MANTIX(45 - 13 downto 23 - 13) when "01101",
                    MANTIX(45 - 14 downto 23 - 14) when "01110",
                    MANTIX(45 - 15 downto 23 - 15) when "01111",
                    MANTIX(45 - 16 downto 23 - 16) when "10000",
                    MANTIX(45 - 17 downto 23 - 17) when "10001",
                    MANTIX(45 - 18 downto 23 - 18) when "10010",
                    MANTIX(45 - 19 downto 23 - 19) when "10011",
                    MANTIX(45 - 20 downto 23 - 20) when "10100",
                    MANTIX(45 - 21 downto 23 - 21) when "10101",
                    MANTIX(45 - 22 downto 23 - 22) when "10110",
                    MANTIX(22 downto 0)            when "10111",
                    MANTIX(21 downto 0) & "0"      when others; -- If we can't find any 1s prior to the last 22 bits, we'll just take the last bits

  result: process (MANTIX, ALL_ZEROS, OFFSET_SIG, SHIFTED_TEMP)
  begin
    if ALL_ZEROS = '1' then
      OFFSET <= "11000";
      SHIFTED <= SHIFTED_TEMP;
      SUB <= '1';
    end if;
    if (MANTIX(47) = '1') then
      SHIFTED <= MANTIX(47 - 1 downto 24);
      OFFSET <= "00001";
      SUB <= '0';
    else
      if (MANTIX(46) = '1') then
        SHIFTED <= MANTIX(47 - 2 downto 23);
        OFFSET <= "00000";
        SUB <= '0';
      else
        OFFSET <= OFFSET_SIG;
        SHIFTED <= SHIFTED_TEMP;
        SUB <= '1';
      end if;
    end if;

  end process;
end architecture;


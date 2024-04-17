
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity OPERANDS_SPLITTER is
  port (
    float      : in  STD_LOGIC_VECTOR(31 downto 0);
    sign   : out STD_LOGIC;
    exp    : out STD_LOGIC_VECTOR(7 downto 0);
    mantix : out STD_LOGIC_VECTOR(22 downto 0));
end entity;

architecture RTL of OPERANDS_SPLITTER is

	

begin
  sign   <=     float(31);
  exp    <=     float(30 downto 23);
  mantix <=    float(22 downto 0);
end architecture;


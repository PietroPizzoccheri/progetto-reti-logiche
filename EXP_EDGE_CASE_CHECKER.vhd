
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity FLAG_SETTER is
  port (
    exp            : in  std_logic_vector(7 downto 0);
    zero_or_denorm : out std_logic;
    norm           : out std_logic;
    inf_or_nan     : out std_logic
  );
end entity;

architecture RTL of FLAG_SETTER is
  component DECODER_2_4 is
    port (
      A : in  STD_LOGIC_VECTOR(0 to 1);
      Y : out STD_LOGIC_VECTOR(0 to 3));
  end component;

  signal or_result  : std_logic;
  signal and_result : std_logic;
  signal Y          : std_logic_vector(0 to 3);

begin
  -- or_result is the result of the OR operation agains every bit of exp
  or_result <= exp(0) or exp(1) or exp(2) or exp(3) or exp(4) or exp(5) or exp(6) or exp(7);
  -- and_result is the result of the AND operation agains every bit of exp
  and_result <= exp(0) and exp(1) and exp(2) and exp(3) and exp(4) and exp(5) and exp(6) and exp(7);

  D: DECODER_2_4
    port map (A(0) => or_result,
              A(1) => and_result,
              Y    => Y
    );
    
    zero_or_denorm <= Y(3);
    norm           <= Y(1);
    inf_or_nan     <= Y(0);

end architecture;


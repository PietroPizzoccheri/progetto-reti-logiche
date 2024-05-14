library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity CS_48 is
  port (X    : in  STD_LOGIC_VECTOR(47 downto 0);
        Y    : in  STD_LOGIC_VECTOR(47 downto 0);
        Z    : in  STD_LOGIC_VECTOR(47 downto 0);
        S    : out STD_LOGIC_VECTOR(47 downto 0);
        Cout : out STD_LOGIC);
end entity;

architecture RTL of CS_48 is

  component FA is
    port (X    : in  STD_LOGIC;
          Y    : in  STD_LOGIC;
          Cin  : in  STD_LOGIC;
          S    : out STD_LOGIC;
          Cout : out STD_LOGIC);
  end component;

  -- Intermediate signal
  signal X_sig, Y_sig                                                                                                                                                                                                                     : STD_LOGIC_VECTOR(47 downto 0);
  signal C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43, C44, C45, C46, C47 : STD_LOGIC;

begin
  -- Carry save adder block
  FA1: FA port map (X(0), Y(0), Z(0), S(0), X_sig(0));
  FA2: FA port map (X(1), Y(1), Z(1), Y_sig(0), X_sig(1));
  FA3: FA port map (X(2), Y(2), Z(2), Y_sig(1), X_sig(2));
  FA4: FA port map (X(3), Y(3), Z(3), Y_sig(2), X_sig(3));
  FA5: FA port map (X(4), Y(4), Z(4), Y_sig(3), X_sig(4));
  FA6: FA port map (X(5), Y(5), Z(5), Y_sig(4), X_sig(5));
  FA7: FA port map (X(6), Y(6), Z(6), Y_sig(5), X_sig(6));
  FA8: FA port map (X(7), Y(7), Z(7), Y_sig(6), X_sig(7));
  FA9: FA port map (X(8), Y(8), Z(8), Y_sig(7), X_sig(8));
  FA10: FA port map (X(9), Y(9), Z(9), Y_sig(8), X_sig(9));
  FA11: FA port map (X(10), Y(10), Z(10), Y_sig(9), X_sig(10));
  FA12: FA port map (X(11), Y(11), Z(11), Y_sig(10), X_sig(11));
  FA13: FA port map (X(12), Y(12), Z(12), Y_sig(11), X_sig(12));
  FA14: FA port map (X(13), Y(13), Z(13), Y_sig(12), X_sig(13));
  FA15: FA port map (X(14), Y(14), Z(14), Y_sig(13), X_sig(14));
  FA16: FA port map (X(15), Y(15), Z(15), Y_sig(14), X_sig(15));
  FA17: FA port map (X(16), Y(16), Z(16), Y_sig(15), X_sig(16));
  FA18: FA port map (X(17), Y(17), Z(17), Y_sig(16), X_sig(17));
  FA19: FA port map (X(18), Y(18), Z(18), Y_sig(17), X_sig(18));
  FA20: FA port map (X(19), Y(19), Z(19), Y_sig(18), X_sig(19));
  FA21: FA port map (X(20), Y(20), Z(20), Y_sig(19), X_sig(20));
  FA22: FA port map (X(21), Y(21), Z(21), Y_sig(20), X_sig(21));
  FA23: FA port map (X(22), Y(22), Z(22), Y_sig(21), X_sig(22));
  FA24: FA port map (X(23), Y(23), Z(23), Y_sig(22), X_sig(23));
  FA25: FA port map (X(24), Y(24), Z(24), Y_sig(23), X_sig(24));
  FA26: FA port map (X(25), Y(25), Z(25), Y_sig(24), X_sig(25));
  FA27: FA port map (X(26), Y(26), Z(26), Y_sig(25), X_sig(26));
  FA28: FA port map (X(27), Y(27), Z(27), Y_sig(26), X_sig(27));
  FA29: FA port map (X(28), Y(28), Z(28), Y_sig(27), X_sig(28));
  FA30: FA port map (X(29), Y(29), Z(29), Y_sig(28), X_sig(29));
  FA31: FA port map (X(30), Y(30), Z(30), Y_sig(29), X_sig(30));
  FA32: FA port map (X(31), Y(31), Z(31), Y_sig(30), X_sig(31));
  FA33: FA port map (X(32), Y(32), Z(32), Y_sig(31), X_sig(32));
  FA34: FA port map (X(33), Y(33), Z(33), Y_sig(32), X_sig(33));
  FA35: FA port map (X(34), Y(34), Z(34), Y_sig(33), X_sig(34));
  FA36: FA port map (X(35), Y(35), Z(35), Y_sig(34), X_sig(35));
  FA37: FA port map (X(36), Y(36), Z(36), Y_sig(35), X_sig(36));
  FA38: FA port map (X(37), Y(37), Z(37), Y_sig(36), X_sig(37));
  FA39: FA port map (X(38), Y(38), Z(38), Y_sig(37), X_sig(38));
  FA40: FA port map (X(39), Y(39), Z(39), Y_sig(38), X_sig(39));
  FA41: FA port map (X(40), Y(40), Z(40), Y_sig(39), X_sig(40));
  FA42: FA port map (X(41), Y(41), Z(41), Y_sig(40), X_sig(41));
  FA43: FA port map (X(42), Y(42), Z(42), Y_sig(41), X_sig(42));
  FA44: FA port map (X(43), Y(43), Z(43), Y_sig(42), X_sig(43));
  FA45: FA port map (X(44), Y(44), Z(44), Y_sig(43), X_sig(44));
  FA46: FA port map (X(45), Y(45), Z(45), Y_sig(44), X_sig(45));
  FA47: FA port map (X(46), Y(46), Z(46), Y_sig(45), X_sig(46));
  FA48: FA port map (X(47), Y(47), Z(47), Y_sig(46), X_sig(47));

  -- Ripple carry adder block
  FA49: FA port map (X_sig(0), Y_sig(0), '0', S(1), C1);
  FA50: FA port map (X_sig(1), Y_sig(1), C1, S(2), C2);
  FA51: FA port map (X_sig(2), Y_sig(2), C2, S(3), C3);
  FA52: FA port map (X_sig(3), y_sig(3), C3, S(4), C4);
  FA53: FA port map (X_sig(4), Y_sig(4), C4, S(5), C5);
  FA54: FA port map (X_sig(5), Y_sig(5), C5, S(6), C6);
  FA55: FA port map (X_sig(6), Y_sig(6), C6, S(7), C7);
  FA56: FA port map (X_sig(7), Y_sig(7), C7, S(8), C8);
  FA57: FA port map (X_sig(8), Y_sig(8), C8, S(9), C9);
  FA58: FA port map (X_sig(9), Y_sig(9), C9, S(10), C10);
  FA59: FA port map (X_sig(10), Y_sig(10), C10, S(11), C11);
  FA60: FA port map (X_sig(11), Y_sig(11), C11, S(12), C12);
  FA61: FA port map (X_sig(12), Y_sig(12), C12, S(13), C13);
  FA62: FA port map (X_sig(13), Y_sig(13), C13, S(14), C14);
  FA63: FA port map (X_sig(14), Y_sig(14), C14, S(15), C15);
  FA64: FA port map (X_sig(15), Y_sig(15), C15, S(16), C16);
  FA65: FA port map (X_sig(16), Y_sig(16), C16, S(17), C17);
  FA66: FA port map (X_sig(17), Y_sig(17), C17, S(18), C18);
  FA67: FA port map (X_sig(18), Y_sig(18), C18, S(19), C19);
  FA68: FA port map (X_sig(19), Y_sig(19), C19, S(20), C20);
  FA69: FA port map (X_sig(20), Y_sig(20), C20, S(21), C21);
  FA70: FA port map (X_sig(21), Y_sig(21), C21, S(22), C22);
  FA71: FA port map (X_sig(22), Y_sig(22), C22, S(23), C23);
  FA72: FA port map (X_sig(23), Y_sig(23), C23, S(24), C24);
  FA73: FA port map (X_sig(24), Y_sig(24), C24, S(25), C25);
  FA74: FA port map (X_sig(25), Y_sig(25), C25, S(26), C26);
  FA75: FA port map (X_sig(26), Y_sig(26), C26, S(27), C27);
  FA76: FA port map (X_sig(27), Y_sig(27), C27, S(28), C28);
  FA77: FA port map (X_sig(28), Y_sig(28), C28, S(29), C29);
  FA78: FA port map (X_sig(29), Y_sig(29), C29, S(30), C30);
  FA79: FA port map (X_sig(30), Y_sig(30), C30, S(31), C31);
  FA80: FA port map (X_sig(31), Y_sig(31), C31, S(32), C32);
  FA81: FA port map (X_sig(32), Y_sig(32), C32, S(33), C33);
  FA82: FA port map (X_sig(33), Y_sig(33), C33, S(34), C34);
  FA83: FA port map (X_sig(34), Y_sig(34), C34, S(35), C35);
  FA84: FA port map (X_sig(35), Y_sig(35), C35, S(36), C36);
  FA85: FA port map (X_sig(36), Y_sig(36), C36, S(37), C37);
  FA86: FA port map (X_sig(37), Y_sig(37), C37, S(38), C38);
  FA87: FA port map (X_sig(38), Y_sig(38), C38, S(39), C39);
  FA88: FA port map (X_sig(39), Y_sig(39), C39, S(40), C40);
  FA89: FA port map (X_sig(40), Y_sig(40), C40, S(41), C41);
  FA90: FA port map (X_sig(41), Y_sig(41), C41, S(42), C42);
  FA91: FA port map (X_sig(42), Y_sig(42), C42, S(43), C43);
  FA92: FA port map (X_sig(43), Y_sig(43), C43, S(44), C44);
  FA93: FA port map (X_sig(44), Y_sig(44), C44, S(45), C45);
  FA94: FA port map (X_sig(45), Y_sig(45), C45, S(46), C46);
  FA95: FA port map (X_sig(46), Y_sig(46), C46, S(47), Cout);
  --FA96: FA port map (X_sig(47), Y_sig(47), C47, S(48), Cout);
  
end architecture;

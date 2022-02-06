entity GameController is
    Port ( Game_Clk : in  STD_LOGIC;
           PS_Key : in  STD_LOGIC_VECTOR (7 downto 0);
           PS_Key_Rdy : in  STD_LOGIC;
           PS_Ext_Code : in  STD_LOGIC;
           PS_Rel_Code : in  STD_LOGIC;
			  Random : in STD_LOGIC_VECTOR (41 downto 0);
           VGA_Char : out  STD_LOGIC_VECTOR (7 downto 0);
           VGA_Print : out  STD_LOGIC;
           VGA_NewLine : out  STD_LOGIC;
           VGA_GT00 : out  STD_LOGIC);
end GameController;

architecture Behavioral of GameController is

type int_array is array(0 to 19) of integer range 0 to 48;
signal PL_Direction : integer range -1 to 1 := 0;
signal Objects_Pos :  int_array;---Array representing positions on the screen where 0th index with value 0 is left bottom corner of the screen (value 48 means empty row)
signal Score : integer := 0; ---Signals if scored
signal random_tmp : integer := 0;
begin

--MAIN GAME LOOP--
process(Game_Clk)
begin
	if rising_edge(Game_Clk) then
		--- Move bucket ---
		if ((Objects_Pos(0) + PL_Direction >= 1) and (Objects_Pos(0) + PL_Direction <= 47)) then
			Objects_Pos(0) <= Objects_Pos(0) + PL_Direction;
		end if;

		--- Check if caught fruit ---
		if ((Objects_Pos(1) >= Objects_Pos(0) - 1) and (Objects_Pos(1) <= Objects_Pos(0) + 1)) then
			Score <= Score + 1;
		end if;

		--- Fruits are falling ---
		Objects_Pos(1 to 18) <= Objects_Pos(2 to 19);

		--- Check if fruit should be generated ---
		if (Objects_Pos(18) = 48)  and (Objects_Pos(17) = 48) then
			--- Generate new fruit in random position  ---
			random_tmp <= to_integer(unsigned(Random(32 downto 0)));
			Objects_Pos(19) <= random_tmp mod 48;
		else
			--- No fruit  ---
			Objects_Pos(19) <= 48;
		end if;


		--- Draw frame ---
	end if;
end process;


---Not sure how keybord will send release button signal
--- I will go with assumption that it changees with sending PS_Key_Rdy

process(sys_clk) --- Changing direction
begin
	if rising_edge(sys_clk) then
		if PS_Key_Rdy = '1' then
			if PS_Key = "01100001"  then ---ASCI 'a'
				if PS_Rel_Code = '1' then --Stopping movement on kbrd btn release
					PL_Direction <= 0;
				else
					PL_Direction <= -1;
				end if;
			elsif PS_Key = "01100100" then---ASCI 'd'
				if PS_Rel_Code = '1' then --Stopping movement on kbrd btn release
					PL_Direction <= 0;
				else
					PL_Direction <= 1;
				end if;
			end if;
		end if;
	end if;
end process;

end Behavioral;

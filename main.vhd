library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity main is
	 Generic ( size : integer := 256 );
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
			  start : in  STD_LOGIC; 
           rst : in  STD_LOGIC;
           b : out  STD_LOGIC_VECTOR (16 downto 0);
           done : out  STD_LOGIC);
end main;

architecture Behavioral of main is
	type rom is array (31 downto 0) of unsigned(16 downto 0);
	signal hist : rom := (others=>(others=>'0'));
	type state_type is (idle, calculate, disp);
	signal state : state_type := idle;
	signal cnt : integer range 0 to (size*size)-1 := 0;
	
begin
	process(clk, rst)
	begin
		if rst='1' then
			hist <= (others=>(others=>'0'));
			state <= idle;
			done <= '0';
			b <= (others => '0');
		elsif (clk'event and clk='1') then
			case state is
				when idle =>
					hist <= hist;
					state <= idle;
					done <= '0';
					b <= (others => '0');
					cnt <= 0;
					if start = '1' then
						state <= calculate;
					end if;
				when calculate =>
					hist <= hist;
					state <= calculate;
					done <= '0';
					b <= (others => '0');
					cnt <= cnt+1;
					if cnt=(size*size)-1 then
						cnt <= 0;
						state <= disp;
					end if;
					if unsigned(a)<8 then
						hist(0) <= hist(0) + 1;
					elsif unsigned(a)<16 then
						hist(1) <= hist(1) + 1;
					elsif unsigned(a)<24 then
						hist(2) <= hist(2) + 1;
					elsif unsigned(a)<32 then
						hist(3) <= hist(3) + 1;
					elsif unsigned(a)<40 then
						hist(4) <= hist(4) + 1;
					elsif unsigned(a)<48 then
						hist(5) <= hist(5) + 1;
					elsif unsigned(a)<56 then
						hist(6) <= hist(6) + 1;
					elsif unsigned(a)<64 then
						hist(7) <= hist(7) + 1;
					elsif unsigned(a)<72 then
						hist(8) <= hist(8) + 1;
					elsif unsigned(a)<80 then
						hist(9) <= hist(9) + 1;
					elsif unsigned(a)<88 then
						hist(10) <= hist(10) + 1;
					elsif unsigned(a)<96 then
						hist(11) <= hist(11) + 1;
					elsif unsigned(a)<104 then
						hist(12) <= hist(12) + 1;
					elsif unsigned(a)<112 then
						hist(13) <= hist(13) + 1;
					elsif unsigned(a)<120 then
						hist(14) <= hist(14) + 1;
					elsif unsigned(a)<128 then
						hist(15) <= hist(15) + 1;
					elsif unsigned(a)<136 then
						hist(16) <= hist(16) + 1;
					elsif unsigned(a)<144 then
						hist(17) <= hist(17) + 1;
					elsif unsigned(a)<152 then
						hist(18) <= hist(18) + 1;
					elsif unsigned(a)<160 then
						hist(19) <= hist(19) + 1;
					elsif unsigned(a)<168 then
						hist(20) <= hist(20) + 1;
					elsif unsigned(a)<176 then
						hist(21) <= hist(21) + 1;
					elsif unsigned(a)<184 then
						hist(22) <= hist(22) + 1;
					elsif unsigned(a)<192 then
						hist(23) <= hist(23) + 1;
					elsif unsigned(a)<200 then
						hist(24) <= hist(24) + 1;
					elsif unsigned(a)<208 then
						hist(25) <= hist(25) + 1;
					elsif unsigned(a)<216 then
						hist(26) <= hist(26) + 1;
					elsif unsigned(a)<224 then
						hist(27) <= hist(27) + 1;
					elsif unsigned(a)<232 then
						hist(28) <= hist(28) + 1;
					elsif unsigned(a)<240 then
						hist(29) <= hist(29) + 1;
					elsif unsigned(a)<248 then
						hist(30) <= hist(30) + 1;
					else
						hist(31) <= hist(31) + 1;	
					end if;
				when disp =>
					hist <= hist;
					state <= disp;
					done <= '1';
					b <= std_logic_vector(hist(cnt));
					cnt <= cnt+1;
					if cnt = 31 then
						state <= idle;
						hist <= (others=>(others=>'0'));
						cnt <= 0;
					end if;
			end case;
		end if;
	end process;

end Behavioral;
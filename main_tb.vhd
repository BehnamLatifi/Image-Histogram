LIBRARY std;
use std.textio.all;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_textio.ALL;
use ieee.numeric_std.all;
 
ENTITY main_tb IS
END main_tb;
 
ARCHITECTURE behavior OF main_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         a : IN  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         start : IN  std_logic;
         rst : IN  std_logic;
         b : OUT  std_logic_vector(16 downto 0);
         done : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal start : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal b : std_logic_vector(16 downto 0);
   signal done : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10*4 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          a => a,
          clk => clk,
          start => start,
          rst => rst,
          b => b,
          done => done
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
	rst <= '1', '0' after 30*4 ns;
	start <= '1', '0' after 40*4 ns;
	
	read_input : process(clk)
		file input_file : text open read_mode is "../test_input.txt";
		variable C : std_logic_vector(7 downto 0);
		variable file_line : line;
		variable sp : integer range 0 to 7 := 0;
	begin
		if sp/=7 then
			sp := sp+1;
		elsif (clk'event and clk='0') then
			if not endfile(input_file) then
				readline (input_file, file_line);
				read (file_line, C);
				a <= C;
			else
				a <= (others=>'0');
			end if;
		end if;
	end process;
	
	write_output : process(clk)
		file output_file : text open write_mode is "../test_output.txt";
		variable file_line : line;
		variable sp : integer range 0 to 65580 := 0;	
	begin
		if (clk'event and clk='0') then
			sp := sp+1;
			if ((65540 < sp ) and (sp < 65573)) then
				write (file_line, to_integer(unsigned(b)));
				writeline (output_file, file_line);
			end if;
		end if;
	end process;	
	
	end_process: process
	begin
		wait for 655800*4 ns;
		assert false
			report "Simulation completed"
		severity failure;
	end process;
END;

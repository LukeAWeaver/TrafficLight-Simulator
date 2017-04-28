----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2017 04:46:02 PM
-- Design Name: 
-- Module Name: tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Test bench for TrafficLight
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
end tb;
architecture Behavioral of tb is
    component TrafficLight is
    Port ( rst : in STD_LOGIC;
   carew : in STD_LOGIC;
   clk : in STD_LOGIC;
   CW: in STD_LOGIC;
   CE: in STD_LOGIC;
   lights:out STD_LOGIC_VECTOR(5 downto 0));
   END COMPONENT;
   signal clk,rst,carew,CW,CE : STD_LOGIC;
   signal lights : STD_LOGIC_VECTOR(5 downto 0);
begin
    mapping : Vending_Machine port map (clk => clk, 
rst => rst, clk => clk, carew=>carew,CW=>CW, CE=>CE, lights=>lights);
process;
begin

end process;

process
 begin
clk <= '1'; wait for 5ns;
clk <= '0'; wait for 5ns;
end process;

end Behavioral;

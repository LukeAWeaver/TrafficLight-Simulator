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
               clk : in STD_LOGIC;
               CW: in STD_LOGIC; --car west
               CE: in STD_LOGIC; --car east
               LeftNS: in STD_LOGIC; --car in NS left turn lane
               lights:out STD_LOGIC_VECTOR(5 downto 0); --NS EW lights
               leftLight: out STD_LOGIC_VECTOR(2 downto 0) ); --NS left turn nights;
   END COMPONENT;
   signal clk,rst,CW,CE,LeftNS : STD_LOGIC;
   signal lights : STD_LOGIC_VECTOR(5 downto 0);
   signal leftLight: STD_LOGIC_VECTOR(2 downto 0);
begin
    mapping : TrafficLight port map (clk => clk, rst => rst, CW=>CW, CE=>CE, LeftNS=>LeftNS, lights=>lights, leftLight=>leftLight);

process
begin
rst <='0';
CW <= '0';
CE <= '0';
LeftNS <= '0';
wait for 100 ns;
CW <= '1';
LeftNS <= '1';
wait for 1000 ns;
CW <= '0';
wait for 400 ns;
LeftNS <= '0';
wait for 500 ns;
CW <= '1';
wait for 2000 ns;
end process;

process
 begin
clk <= '1'; wait for 5 ns;
clk <= '0'; wait for 5 ns;
end process;

end Behavioral;

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
    Port (     rst,clk,CW,CE,LeftNS : in STD_LOGIC;
               lights:out STD_LOGIC_VECTOR(5 downto 0):="000000"; --NS EW lights
               leftLight: out STD_LOGIC_VECTOR(2 downto 0):="000"); --NS left turn nights;
   END COMPONENT;
   signal rst,clk,CW,CE,LeftNS : STD_LOGIC;
   signal lights : STD_LOGIC_VECTOR(5 downto 0);
   signal leftLight: STD_LOGIC_VECTOR(2 downto 0):="000";
begin
    mapping : TrafficLight port map (rst => rst, 
    clk => clk,CW=>CW, CE=>CE, LeftNS=>LeftNS,
    lights=>lights,leftLight=>leftLight);
    
process
begin
rst<='1';CW <= '0';CE <= '0';LeftNS <='0';
wait for 20 ns;
rst <='0';
wait for 1000000000 ns; --1 second delay

CW <= '1';LeftNS <= '1';
wait for 1000000000 ns; --4 second delay
wait for 1000000000 ns;
wait for 1000000000 ns;
wait for 1000000000 ns;

CW <= '0';
wait for 1000000000 ns; -- 1s delay

LeftNS <= '0';
wait for 1000000000 ns; --5 second delay
wait for 1000000000 ns;
wait for 1000000000 ns;
wait for 1000000000 ns;
wait for 1000000000 ns;
end process;

process
 begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
end process;

end Behavioral;


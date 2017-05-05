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
            port(rst: in std_logic;
                 clk : in std_logic;
                 CW: in std_logic; --car west
                 CE: in std_logic; --car east
                 LeftNS: in std_logic; --car in NS left turn lane
                 lights:out std_logic_vector(5 downto 0); --NS EW lights
                 leftLight: out std_logic_vector(2 downto 0)); --NS left turn nights;
        end component;
        signal clk,rst,CW,CE,LeftNS: std_logic;
        signal lights: std_logic_vector(5 downto 0);
        signal leftLight: std_logic_vector(2 downto 0);
    begin
        mapping: TrafficLight port map (clk => clk, 
                                        rst => rst, 
                                        CW => CW, 
                                        CE => CE, 
                                        LeftNS => LeftNS, 
                                        lights => lights, 
                                        leftLight => leftLight);

    process
    begin
        rst <='0'; CW <= '0'; CE <= '0'; LeftNS <= '0';
        wait for 100 ns;
        CW <= '1'; LeftNS <= '1';
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
        clk <= '1'; 
        wait for 5 ns;
        clk <= '0'; 
        wait for 5 ns;
    end process;

end Behavioral;

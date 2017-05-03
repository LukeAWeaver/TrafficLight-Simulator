----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2017 04:18:57 PM
-- Design Name: 
-- Module Name: TrafficLight - Behavioral
-- Project Name: TrafficLight
-- Target Devices: 
-- Tool Versions: 
-- Description: 

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TrafficLight is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           CW: in STD_LOGIC; --car west
           CE: in STD_LOGIC; --car east
           LeftNS: in STD_LOGIC; --car in NS left turn lane
           lights:out STD_LOGIC_VECTOR(5 downto 0); --NS EW lights
           leftLight: out STD_LOGIC_VECTOR(2 downto 0)); --NS left turn nights
end TrafficLight;

architecture Behavioral of TrafficLight is
    type state_type is (GNS, YNS,GEW,YEW, LeftGNS, LeftYNS);
    signal state: state_type;
    signal count : integer := 1;
    signal leftSwap : std_logic :='1';
begin
    process(clk, rst)
    begin

    if (rst = '1') then
        count <= 1;
        lights <="100001";
        leftLight <= "001";
        state <= GNS;

    elsif(rising_edge(clk)) then

        count <= count + 1;

        case state is

            when GNS =>
                -- green North South Red east west
                lights <="100001";
                leftLight(0) <= '0';
                -- toggle left turn yellow light on and off
                if(count mod 50000000 = 0) then
                    leftSwap <= not leftSwap;
                    leftLight(1) <= leftSwap;
                end if;
                -- if a car arrives east west then switch lights
                if(CW = '1' or CE = '1') then
                    if (count > 500000000) then
                        count <= 1;
                        state <= YNS;
                    else 
                        state <=GNS;
                end if;
                end if;

            when YNS => 
                lights <="010001";
                leftLight <= "010";
                - -stay yellow for three seconds
                if(count > 300000000) THEN
                    count <= 1;
                    state <= GEW;
                else 
                    state <=YNS;
                end if;

            when GEW =>
                lights <="001100";
                leftLight <= "001";
                if((CW = '0' AND CE ='0') OR count > 500000000) then
                    count <= 1;
                    state <=YEW;
                else 
                    state <=GEW;
                end if;

            when YEW =>
                lights <="001010";
                -- stay yellow for 
                if(count > 300000000) then
                count <=1;
                    -- if there is someone in left turn lane then go to LeftGNS
                    if(LeftNS = '1') then
                        state <= LeftGNS;
                    else
                        state <= GNS;
                    end if;
                else 
                    state <=YEW;
                end if;
     
             when LeftGNS =>
                --both NS and EW lights are red
                lights <= "001001";
                leftLight <="100";
                --only stay green for 4 seconds
                if(count > 400000000) then
                    count <= 1;
                    state <= LeftYNS;
                else
                    state <= LeftGNS;
                end if;
                    
             when LeftYNS =>
                --NS EW lights stay red while left turn goes to yellow
                lights <= "001001";
                leftLight <= "010";
                if(count > 300000000) then
                    count <= 1;
                    state <= GNS;
                end if;
        end case;

    end if;

end process;
end Behavioral;

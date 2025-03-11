library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity fetch is
Port ( 
   CLK                 : in  STD_LOGIC;
   resetn              : in  STD_LOGIC;
   enable_f            : in  STD_LOGIC;
   enable_m            : in  STD_LOGIC;
   jumpOrBranchAddress : in  STD_LOGIC_VECTOR (31 downto 0);
   jumpOrBranch        : in  STD_LOGIC;
   pc_value            : out STD_LOGIC_VECTOR (31 downto 0)
 );
end fetch;

architecture arch of fetch is

    signal pc_reg : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal pc_next : STD_LOGIC_VECTOR(31 downto 0);

begin

    process(CLK, resetn)
    begin
        if resetn = '0' then
            pc_reg <= (others => '0');
        elsif rising_edge(CLK) then
            if enable_f = '1' then
                if jumpOrBranch = '1' then
                    pc_reg <= jumpOrBranchAddress;
                else
                    pc_reg <= pc_next;
                end if;
            end if;
        end if;
    end process;

    pc_next <= std_logic_vector(unsigned(pc_reg) + 4);
    pc_value <= pc_reg;

end arch;

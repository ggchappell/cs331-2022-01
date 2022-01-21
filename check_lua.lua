#!/usr/bin/env lua
-- check_lua.lua
-- Glenn G. Chappell
-- 2022-01-20
--
-- For CS F331 / CSCE A331 Spring 2022
-- A Lua Program to Run
-- Used in Assignment 1, Exercise 1


-- A mysterious table
tt = {[=[DH]=],"UXWM",[2*3]='QYFT'..[==[XLUF]==],[2+2]='FUNVO',
      [2+[[3]]]=[=[[]=]..'R'..[====[ZZ]====],[3]=[[VR]]}


-- And a mysterious function
function ff(z)
    local k,x,r=74,38,35
    k = k-r - x x = x - r-k r=[===[]===]
    for y = 1,z :len() do
        r = r..string.char(string.byte(z,y)-(x%9))
        k, x = x, k+x
    end
    return r
end


-- Formatted output using the function and the table entries
io.write("Here is the secret message:\n\n")
io.write(string.format([[%s %]]..[==[s %s %s %]==]..'s %s\n',
         ff(tt[1]),ff(tt[2]),ff(tt[3]),ff(tt[4]),ff(tt[5]),ff(tt[6])))

io.write("\n")
-- Uncomment the following to wait for the user before quitting
--io.write("Press ENTER to quit ")
--io.read("*l")


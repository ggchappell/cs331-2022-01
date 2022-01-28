#!/usr/bin/env lua
-- overload.lua
-- Glenn G. Chappell
-- 2022-01-28
--
-- For CS F331 / CSCE A331 Spring 2022
-- Code from 1/28 reading - Operator Overloading in Lua


io.write("This file contains sample code from January 28, 2022,\n")
io.write("for the reading \"Operator Overloading in Lua\".\n")
io.write("It will execute, but it is not intended to do anything\n")
io.write("useful. See the source.\n")


io.write("\n*** Operator Overloading:\n")

-- We demonstrate Lua's operator overloading using tables that hold a
-- number in the value associated with key "n".

-- Here is our metatable, which defines the binary "+" and "*"
-- operators. The special function names are "__add" and "__mul".

opmt = {}  -- "opmt" = OPerator MetaTable

function opmt.__add(t1, t2)
    local t3 = {}
    setmetatable(t3, opmt)
    t3.n = t1.n + t2.n
    return t3
end

function opmt.__mul(t1, t2)
    local t3 = {}
    setmetatable(t3, opmt)
    t3.n = t1.n * t2.n
    return t3
end

-- Now we make two tables with the above as their metatable and use the
-- overloaded "+" and "*" operators.

-- Numbers that we will operate on:
num_a = 3
num_b = 5
num_c = 4

ta = { ["n"]=num_a }
setmetatable(ta, opmt)
tb = { ["n"]=num_b }
setmetatable(tb, opmt)
tc = { ["n"]=num_c }
setmetatable(tc, opmt)

-- The above would be simpler if we make a "constructor" (see
-- Lua: Objects).

td = ta + tb * tc  -- Use overloaded "+" and "*" operators

io.write("Using overloaded \"+\" and \"*\" operators:\n  ")
io.write(num_a.." + "..num_b.." * "..num_c.." = "..td.n.."\n")


io.write("\n")
io.write("This file contains sample code from January 28, 2022,\n")
io.write("for the reading \"Operator Overloading in Lua\".\n")
io.write("It will execute, but it is not intended to do anything\n")
io.write("useful. See the source.\n")

io.write("\n")
-- Uncomment the following to wait for the user before quitting
--io.write("Press ENTER to quit ")
--io.read("*l")


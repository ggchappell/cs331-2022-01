-- evaluator.lua  UNFINISHED
-- Glenn G. Chappell
-- 2022-03-28
--
-- For CS F331 / CSCE A331 Spring 2022
-- Evaluator for Arithmetic Expression AST (rdparser3.lua format)
-- Used by evalmain.lua


local evaluator = {}  -- Our module


-- Symbolic Constants for AST

local BIN_OP     = 1
local NUMLIT_VAL = 2
local SIMPLE_VAR = 3


-- Named Variables

varValues = {
    ["e"]   = 2.71828182845904523536,
    ["pi"]  = 3.14159265358979323846,
    ["phi"] = 1.61803398874989484820,
    ["tau"] = 6.28318530717958647693,
    ["zero"] = 0,
    ["one"] = 1,
    ["two"] = 2,
    ["three"] = 3,
    ["four"] = 4,
    ["five"] = 5,
    ["six"] = 6,
    ["seven"] = 7,
    ["eight"] = 8,
    ["nine"] = 9,
    ["ten"] = 10,
    ["eleven"] = 11,
    ["twelve"] = 12,
    ["answer"] = 42,
    ["year"] = 2022,
}


-- Primary Function

-- evaluator.eval
-- Takes AST in form specified in rdparser3.lua. Returns numeric value.
-- No error checking is done.
function evaluator.eval(ast)
    return 42  -- DUMMY
    -- TODO: WRITE THIS!!!
end


-- Module Export

return evaluator


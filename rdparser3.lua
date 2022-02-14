-- rdparser3.lua  UNFINISHED
-- Glenn G. Chappell
-- 2021-02-15
--
-- For CS F331 / CSCE A331 Spring 2021
-- Recursive-Descent Parser #3: Expressions
-- Requires lexer.lua


-- Grammar
-- Start symbol: expr
--
--     expr    ->  term { ("+" | "-") term }
--     term    ->  factor { ("*" | "/") factor }
--     factor  ->  ID
--              |  NUMLIT
--              |  "(" expr ")"
--
-- All operators (+ - * /) are left-associative.
--
-- AST Specification
-- - For an ID, the AST is { SIMPLE_VAR, SS }, where SS is the string
--   form of the lexeme.
-- - For a NUMLIT, the AST is { NUMLIT_VAL, SS }, where SS is the string
--   form of the lexeme.
-- - For expr -> term, then AST for the expr is the AST for the term,
--   and similarly for term -> factor.
-- - Let X, Y be expressions with ASTs XT, YT, respectively.
--   - The AST for ( X ) is XT.
--   - The AST for X + Y is { { BIN_OP, "+" }, XT, YT }. For multiple
--     "+" operators, left-asociativity is reflected in the AST. And
--     similarly for the other operators.

local lexer = require "lexer"


-- *********************************************************************
-- Module Table Initialization
-- *********************************************************************


local rdparser3 = {}  -- Our module


-- *********************************************************************
-- Variables
-- *********************************************************************


-- For lexer iteration
local iter          -- Iterator returned by lexer.lex
local state         -- State for above iterator (maybe not used)
local lexer_out_s   -- Return value #1 from above iterator
local lexer_out_c   -- Return value #2 from above iterator

-- For current lexeme
local lexstr = ""   -- String form of current lexeme
local lexcat = 0    -- Category of current lexeme:
                    --  one of categories below, or 0 for past the end


-- *********************************************************************
-- Symbolic Constants for AST
-- *********************************************************************


local BIN_OP     = 1
local NUMLIT_VAL = 2
local SIMPLE_VAR = 3


-- *********************************************************************
-- Utility Functions
-- *********************************************************************


-- advance
-- Go to next lexeme and load it into lexstr, lexcat.
-- Should be called once before any parsing is done.
-- Function init must be called before this function is called.
local function advance()
    -- Advance the iterator
    lexer_out_s, lexer_out_c = iter(state, lexer_out_s)

    -- If we're not past the end, copy current lexeme into vars
    if lexer_out_s ~= nil then
        lexstr, lexcat = lexer_out_s, lexer_out_c
    else
        lexstr, lexcat = "", 0
    end
end


-- init
-- Initial call. Sets input for parsing functions.
local function init(prog)
    iter, state, lexer_out_s = lexer.lex(prog)
    advance()
end


-- atEnd
-- Return true if pos has reached end of input.
-- Function init must be called before this function is called.
local function atEnd()
    return lexcat == 0
end


-- matchString
-- Given string, see if current lexeme string form is equal to it. If
-- so, then advance to next lexeme & return true. If not, then do not
-- advance, return false.
-- Function init must be called before this function is called.
local function matchString(s)
    if lexstr == s then
        advance()
        return true
    else
        return false
    end
end


-- matchCat
-- Given lexeme category (integer), see if current lexeme category is
-- equal to it. If so, then advance to next lexeme & return true. If
-- not, then do not advance, return false.
-- Function init must be called before this function is called.
local function matchCat(c)
    if lexcat == c then
        advance()
        return true
    else
        return false
    end
end


-- *********************************************************************
-- "local" Statements for Parsing Functions
-- *********************************************************************


local parse_expr
local parse_term
local parse_factor


-- *********************************************************************
-- The Parser: Function "parse" - EXPORTED
-- *********************************************************************


-- parse
-- Given program, initialize parser and call parsing function for start
-- symbol. Returns pair of booleans & AST. First boolean indicates
-- successful parse or not. Second boolean indicates whether the parser
-- reached the end of the input or not. AST is only valid if first
-- boolean is true.
function rdparser3.parse(prog)
    -- Initialization
    init(prog)

    -- Get results from parsing
    local good, ast = parse_expr()  -- Parse start symbol
    local done = atEnd()

    -- And return them
    return good, done, ast
end


-- *********************************************************************
-- Parsing Functions
-- *********************************************************************


-- Each of the following is a parsing function for a nonterminal in the
-- grammar. Each function parses the nonterminal in its name and returns
-- a pair: boolean, AST. On a successul parse, the boolean is true, the
-- AST is valid, and the current lexeme is just past the end of the
-- string the nonterminal expanded into. Otherwise, the boolean is
-- false, the AST is not valid, and no guarantees are made about the
-- current lexeme. See the AST Specification near the beginning of this
-- file for the format of the returned AST.

-- NOTE. Declare parsing functions "local" above, but not below. This
-- allows them to be called before their definitions.


-- parse_expr
-- Parsing function for nonterminal "expr".
-- Function init must be called before this function is called.
function parse_expr()
    -- WRITE THIS!!!
    return false, nil  -- DUMMY
end


-- parse_term
-- Parsing function for nonterminal "term".
-- Function init must be called before this function is called.
function parse_term()
    -- WRITE THIS!!!
    return false, nil  -- DUMMY
end


-- parse_factor
-- Parsing function for nonterminal "factor".
-- Function init must be called before this function is called.
function parse_factor()
    -- WRITE THIS!!!
    return false, nil  -- DUMMY
end


-- *********************************************************************
-- Module Table Return
-- *********************************************************************


return rdparser3


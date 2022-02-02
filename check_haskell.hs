-- check_haskell.hs
-- Glenn G. Chappell
-- 2022-02-01
--
-- For CS F331 / CSCE A331 Spring 2022
-- A Haskell Program to Run
-- Used in Assignment 2, Exercise 1

module Main where


-- main
-- Print second secret message.
main = do
    putStrLn "Secret message #2:"
    putStrLn ""
    putStrLn secret_message


-- secret_message
-- A mysterious message.
secret_message = map xk xj where
    xa = [64,33,-71,48,-15,-6,9,-2]
    xb = [11,-59,81,0,-5,-15,-71,82]
    xc = [-7,-81,66,12,-11,3,-5,-77]
    xd = [87,-12,4,-5,-84,45,37,-23]
    xe = [9,6,-13,3,-11,-70]
    xf = [2,-13,17,31,-14,6]
    xg = "The treasure is buried under a palm tree on the third island."
    xh = map (+ xl) $ concat [xa, xb, xc, xd, xe]
    xi a as = a : map (+ a) as
    xj = foldr xi [] xh
    xk a = toEnum a `asTypeOf` (head xg)
    xl = head xf


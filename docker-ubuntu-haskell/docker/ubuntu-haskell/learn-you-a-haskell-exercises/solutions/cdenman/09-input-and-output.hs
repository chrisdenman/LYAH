import System.Environment
import System.Random
import Data.List

{-
 - Lets implement the UNIX echo command
 - The program arguments are simply printed to the standard output.
 - If the first argument is -n, this argument is not printed, and no trailing newline is printed
 -}
  
main = do
    args <- getArgs
    case args of
        (x:xs)  -> putStr $ intercalate " " $ if x == "-n" then xs else args ++ ["\n"]
        _       -> putStrLn "no args"

{- Write a lottery number picker
 - This function should take a StdGen instance, and produce a list of six unique numbers between 1 and 49, in numerical order
 -}
lottery :: StdGen -> [Int]
lottery = take 6 $ nub $ randomRs (1,49)

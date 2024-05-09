import Data.Char

-- This function should print a single digit number as English text, or "unknown" if it's out of the range 0-9
englishDigit :: Int -> String
englishDigit 0  = "0"
englishDigit 1  = "1"
englishDigit 2  = "2"
englishDigit 3  = "3"
englishDigit 4  = "4"
englishDigit 5  = "5"
englishDigit 6  = "6"
englishDigit 7  = "7"
englishDigit 8  = "8"
englishDigit 9  = "9"
englishDigit x  = "unknown"

englishDigit2 :: Int -> String
englishDigit2 number
    | (number >= 0 && number <= 9) = (chr (number + 48)) : []
    | otherwise = "unknown"

-- given a tuple, divide fst by snd, using pattern matching.
-- it should return undefined for division by zero
divTuple :: (Eq a, Fractional a) => (a, a) -> a
divTuple (x, 0) = undefined
divTuple (x, y) = x / y

-- if the first three numbers in a list are all zero, return True
threeZeroList :: [Int] -> Bool
threeZeroList (0:0:0:xs) = True
threeZeroList _ = False

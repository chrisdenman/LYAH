import Data.List

{-
 - We are going to create some types for a deck of cards
 - The cards need to have an ordering, based on the standard ranking http://en.wikipedia.org/wiki/Standard_52-card_deck#Rank_and_color
 - We are assuming Aces are high.
 - Therefore, the following statements should be true:
 -    (Card Ace Spades) > (Card King Spades)
 -    (Card Two Clubs) < (Card Three Clubs)
 -
 - We are going to provide our own implementation of the Show typeclass for the Card type.
 - When displaying the Card instance in GHCI, or calling show (Card digit suit), the String which should be displayed is "The <Digit> of <Suit>"
 -
 - Uncomment the following declarations to complete the implementation, and provide an implementation for instance Show Card
 -}

data Suit = Clubs | Diamonds | Hearts | Spades
    deriving (Eq, Show)

data Digit = D1 | D2 | D3 | D4 | D5 | D6 | D7 | D8 | D9 | D10 | DJ | DQ | DK | DA
    deriving (Ord, Eq)
instance Show Digit where
    show D1 = "1"
    show D2 = "2"
    show D3 = "3"
    show D4 = "4"
    show D5 = "5"
    show D6 = "6"
    show D7 = "7"
    show D8 = "8"
    show D9 = "9"
    show D10 = "10"
    show DJ = "Jack"
    show DQ = "Queen"
    show DK = "King"
    show DA = "Ace"

data Card = Card { digit :: Digit, suit:: Suit }
    deriving (Eq)

instance Show Card where
    show Card{digit=digit, suit=suit} = show digit ++ " of " ++ show suit

-- We should be able to provide a function which returns the higher ranked card:
betterCard :: Card -> Card -> Card
betterCard c0@Card{digit=d0} c1@Card{digit=d1} = if d0 > d1 then c0 else if d0 < d1 then c1 else undefined

-- Here is a new Typeclass, which represents some kind of playing hand in a game.
-- It returns True for a "winning hand", depending on the rules for the type of class we are playing with
class Hand a where
    play :: [a] -> Bool

-- Implement Hand for Card, where play returns true if the list contains the Ace of Spades
instance Hand Card where
    play c = elem Card {digit=DA, suit=Spades} c

-- Create a new Coin type
data Coin = Heads | Tails
    deriving (Eq)

-- Implement Hand for Coin, where play returns true if there are ten heads in a row in the list
instance Hand Coin where
    play c = isInfixOf (replicate 10 Heads) c

-- Have a play with implementing Hand for some other types, for instance Int and Bool
instance Hand Int where
    play c = isPrefixOf [1,2,3] c

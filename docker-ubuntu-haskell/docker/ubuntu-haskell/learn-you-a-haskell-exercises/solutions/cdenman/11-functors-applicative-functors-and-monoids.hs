import Control.Applicative
import Data.Monoid

-- We can use the following type to simulate our own list
data List a = Empty | Value a (List a) deriving (Show)

-- Make the list a Functor
instance Functor List where
    fmap _ Empty = Empty
    fmap f (Value h t) = Value (f h) $ fmap f t

-- Write a function which appends one list on to another
(+++) :: List a -> List a -> List a
(+++)  Empty l = l                                                    -- ap.0
(+++)  l Empty = l                                                    -- ap.1
(+++)  (Value a Empty) l = Value a l
(+++)  (Value h0 t0) l = Value h0 $ t0 +++ l

-- Make our list a Monoid
instance Semigroup (List a) where
    (<>) = (+++)
instance Monoid (List a) where
    mempty = Empty                                                   -- ml.0
    
-- Make our list an Applicative
instance Applicative List where
    pure x = Value x Empty                                          --  al.0
    Empty <*> _ = Empty                                             --  al.1
    (Value f _) <*> something = fmap f something                    --  al.2

-- Make sure that the List obeys the laws for Applicative and Monoid
{-
    In the following, let's denote our list in the standard way as:

        Empty = []
        Value a0 (Value a1 (... Value a(n-1) Empty)) = [a0, a1, ... , an-1] (n>0)

    I'll show that the first Applicative law holds for our List, viz:

        pure f <*> x = fmap f x                                         a.1

    case of an empty list:

            pure f <*> x                                                LHS of (a.1)
        =   pure f <*> []                                               {x↦[]}
        =   [f] <*> []                                                  (al.0)
        =   fmap f []                                                   (al.2)
        =   fmap f x                                                    {[]↦x}

    case of a non empty list:

            pure f <*> x                                                LHS of (a.1)
        =   pure f <*> []                                               {x↦[a0, a1, ... , an-1]}
        =   [f] <*> [a0, a1, ... , an-1]                                (al.0)
        =   fmap f [a0, a1, ... , an-1]                                 (al.2)
        =   fmap f x                                                    {[a0, a1, ... , an-1]↦x}

    Show that the Monoid laws hold for our List, viz:

        mempty `mappend` x = x                                          m.1
        x `mappend` mempty = x                                          m.2
        (x `mappend` y) `mappend` z = x `mappend` (y `mappend` z)       m.3

    case m.1 for an empty list:

            mempty `mappend` x                                          LHS of (m.1)
        =   [] `mappend` x                                              {mempty↦[]}
        =   [] `mappend` []                                             {x↦[]}
        =   [] (<>) []                                                  {`mappend`↦(<>)}
        =   [] (+++) []                                                 {(<>)↦(+++)}
        =   []                                                          (ap.0)
        =   RHS (m.1) under {x↦[]}

    case m.2 for a non empty list:

            mempty `mappend` x                                          LHS of (m.1)
        =   [] `mappend` X                                              {mempty↦[]}
        =   [] `mappend` [a0, a1, ... , an-1]                           {x↦[a0, a1, ... , an-1]}
        =   [] (<>) [a0, a1, ... , an-1]                                {`mappend`↦(<>)}
        =   [] (+++) [a0, a1, ... , an-1]                               {(<>)↦(+++)}
        =   [a0, a1, ... , an-1]                                        (ap.0)
        =   RHS (m.1) under {x↦[]}

    (m.2) is proved almost identically albeit by using (ap.1) instead of (ap.0).

    case m.3 for non empty lists: x, y, z:

            (x `mappend` y) `mappend` z                                 LHS of (m.3)
        =   ([xi] `mappend` [yj]) `mappend` [zk]                        {x↦[xi], y↦[yj], z↦[zk]}
        =   ([xi] (<>) [yj]) (<>) [zk]                                  {`mappend`↦(<>)}
        =   ([xi] (+++) [yj]) (+++) [zk]                                {(<>)↦(+++)}
        =   [xi, yi] (+++) [zk]                                         Definition of +++
        =   [xi, yi, zk]                                                Definition of +++            - r0

            x `mappend` (y `mappend` z)                                 RHS of (m.3)
        =   [xi] `mappend` ([yj] `mappend` [zk])                        {x↦[xi], y↦[yj], z↦[zk]}
        =   [xi] (<>) ([yj] (<>) [zk])                                  {`mappend`↦(<>)}
        =   [xi] (+++) ([yj]) (+++) [zk])                               {(<>)↦(+++)}
        =   [xi] (+++) [yj, zk]                                         Definition of +++
        =   [xi, yi, zk]                                                Definition of +++            - r1

    , compare (r0), (r1)

    I've taken a few 'liberties' here with not explicitly showing how (+++) concatenates non empty lists.

    The rest of the cases are simply a box-ticking exercise.
-}

-- Create some lists of numbers of different lengths such as:
--twoValueList = Value 10 $ Value 20 Empty
i0 = Empty
i1 = Value 0 i0
i2 = Value 1 $ i1
i3 = Value 2 $ i2
i4 = Value 3 $ i3
i5 = Value 4 $ i4

-- Use <$> on the lists with a single-parameter function, such as:
--plusTwo = (+2)
--(+2) <$> i2
--pure (+2) <*> i2

-- Use <$> and <*> on the lists with a binary function
--pure (+1) <*> i3
--pure (+) <*> i3 <*> i1
--(+) <$> i3 <*> i1

--(*) <$> i5 <*> i5

-- Create some lists of binary functions
--v0 = Empty
--v1 = Value (+) v0
--v2 = Value (-) v1

-- Use <*> on the binary functions list and the number lists
--v2 <*> i2 <*> i3

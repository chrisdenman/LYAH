module DistanceConversions
( yardsToFeet
, feetToInches
, inchesToCentimetres
, centimetresToMetres
, chainsToYards
) where

-- Define chains to yards
chainsToYards ::  Float -> Float
chainsToYards y = y * 22

-- Define yards to feet
yardsToFeet ::  Float -> Float
yardsToFeet y = y * 3

-- Define feet to inches
feetToInches :: Float -> Float
feetToInches f = f * 12

-- Define inches to centimetres
inchesToCentimetres :: Float -> Float
inchesToCentimetres inches = 254 * inches / 100 -- error on this line in the original 'i' vs 'inches'

centimetresToMetres :: Float -> Float
centimetresToMetres cm = cm / 100

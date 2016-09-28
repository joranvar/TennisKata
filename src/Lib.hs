-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain types
    Score(..)
  , Point(..)
  , Player(..)

  -- * Main function
  , score

   -- * Util function
  , pointsFor
  , other
  ) where

data Score = Score Point Point
           | Game Player
           | Advantage Player
  deriving (Eq, Show)

data Point = Love | Fifteen | Thirty | Forty
  deriving (Enum, Eq, Bounded, Show)

data Player = Player1 | Player2
  deriving (Bounded, Enum, Show, Eq)

pointsFor :: Player -> Point -> Point -> Score
pointsFor Player1 p1 p2 = Score p1 p2
pointsFor Player2 p2 p1 = Score p1 p2

other :: Player -> Player
other Player1 = Player2
other Player2 = Player1

score :: Player -> Score -> Score
score Player1 (Score p1 p2)
  | p2 == Forty && p1 == Forty = Advantage Player1
  | p1 == Forty = Game Player1
  | otherwise = Score (succ p1) p2
score Player2 (Score p1 p2)
  | p2 == Forty && p1 == Forty = Advantage Player2
  | p2 == Forty = Game Player2
  | otherwise = Score p1 (succ p2)
score _ (Game p) = Game p
score p (Advantage o)
  | p == o = Game p
  | otherwise = Score Forty Forty

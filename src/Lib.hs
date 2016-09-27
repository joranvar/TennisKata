-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain types
    Score (..)
  , Points (..)
  , Player (..)
    -- * Function
  , score
    -- * Util function
  , other
  ) where

data Score = Score Points Points
           | Game Player
           | Advantage Player
  deriving (Eq)
data Points = Love | Fifteen | Thirty | Forty
  deriving (Eq, Bounded, Enum, Show)
data Player = Player1 | Player2
  deriving (Eq, Bounded, Enum, Show)

score :: Player -> Score -> Score
score p (Score Forty Forty) = Advantage p
score p (Advantage o)
  | o /= p = Score Forty Forty
score Player1 (Score p q)
  | p == Forty = Game Player1
  | otherwise = Score (succ p) q
score Player2 (Score p q)
  | q == Forty = Game Player2
  | otherwise = Score p (succ q)
score _ (Game p) = Game p
score p _ = Game p

other :: Player -> Player
other Player1 = Player2
other Player2 = Player1

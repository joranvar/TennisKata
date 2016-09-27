-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain types
    Score (..)
  , Points (..)
  , Player (..)
    -- * Function
  , score
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
score p _ = Game p

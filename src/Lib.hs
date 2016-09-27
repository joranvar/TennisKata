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
  deriving (Eq)
data Points = Love | Fifteen | Thirty | Forty
  deriving (Eq, Bounded, Enum, Show)
data Player = Player1 | Player2
  deriving (Eq)

score :: Player -> Score -> Score
score _ _ = Game Player1

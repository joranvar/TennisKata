-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain types
    Score(..)
  , Point(..)
  , Player(..)
  ) where

-- | The game score
data Score = Game Player
           | Advantage Player
           | Deuce
           | Points Point Point
  deriving (Eq, Show)

-- | The players
data Player = Player1 | Player2
  deriving (Eq, Show, Enum, Bounded)

-- | The points
data Point = Love | Fifteen | Thirty | Forty
  deriving (Eq, Show, Enum, Bounded)

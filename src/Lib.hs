-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain types
    Score(..)
  , Point(..)
  , Player(..)
  ) where

-- | The score of a game of tennis
data Score = Points Point Point
           | Advantage Player
           | Deuce
           | Game Player
  deriving (Eq, Show)

-- | The possible points
data Point = Love | Fifteen | Thirty | Forty
  deriving (Eq, Show, Enum, Bounded)

-- | The players
data Player = Player1 | Player2
  deriving (Eq, Show, Enum, Bounded)

-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Exported types
    Score(..)
  , Point(..)
  , Player(..)
  ) where

-- | The players
data Player = Player1 | Player2
  deriving (Eq, Show)

-- | The point system
data Point = Love | Fifteen | Thirty | Forty
  deriving (Eq, Show)

-- | The current score
data Score = Game Player
           | Advantage Player
           | Deuce
           | Points Point Point
  deriving (Eq, Show)

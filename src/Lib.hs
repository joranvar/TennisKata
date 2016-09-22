-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain types
    Player(..)
  , Point(..)
  , Score(..)
    -- * Functions
  , score
  , other
  ) where

-- | The players
data Player = Player1 | Player2
  deriving (Show, Eq, Enum, Bounded)

-- | The points
data Point = Love | Fifteen | Thirty | Forty
  deriving (Show, Eq, Enum, Bounded)

-- | The score
data Score = Game Player
           | Advantage Player
           | Deuce
           | Points Point Point
  deriving (Show, Eq)

-- | Calculating the next score
score :: Player -- ^ The winner
      -> Score -- ^ The score
      -> Score -- ^ The new score
score p Deuce = Advantage p
score p (Advantage o)
  | p /= o = Deuce
score p _ = Game p

-- | The other player
other :: Player -- ^ The player
      -> Player -- ^ The other player
other Player1 = Player2
other Player2 = Player1

-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain types
    Score(..)
  , Point(..)
  , Player(..)
    -- * The functions
  , score
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

-- | Advance the score
score :: Player -- ^ The winner
      -> Score  -- ^ The previous score
      -> Score  -- ^ The new score
score Player1 (Points Forty _) = Game Player1
score Player2 (Points _ Forty) = Game Player2
score Player1 (Points Thirty Forty) = Deuce
score Player2 (Points Forty Thirty) = Deuce
score Player1 (Points p q) = Points (succ p) q
score Player2 (Points p q) = Points p (succ q)
score player Deuce = Advantage player
score _ _ = Deuce

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

-- | Get the next score after a ball
score :: Player -- ^ The scoring player
      -> Score -- ^ The previous score
      -> Score -- ^ The resulting score
score Player1 (Points Thirty Forty) = Deuce
score Player1 (Points Forty _) = Game Player1
score Player1 (Points p q) = Points (succ p) q
score Player2 (Points Forty Thirty) = Deuce
score Player2 (Points _ Forty) = Game Player2
score Player2 (Points p q) = Points p (succ q)
score _ (Advantage _) = Deuce
score _ Deuce = Deuce
score _ (Game _) = Deuce

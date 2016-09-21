-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Exported types
    Score(..)
  , Point(..)
  , Player(..)
    -- * Utility functions
  , newGame
   -- * Scoring the game
  , score
  ) where

-- | The players
data Player = Player1 | Player2
  deriving (Eq, Show, Enum, Bounded)

-- | The point system
data Point = Love | Fifteen | Thirty | Forty
  deriving (Eq, Show, Enum, Bounded)

-- | The current score
data Score = Game Player
           | Advantage Player
           | Deuce
           | Points Point Point
  deriving (Eq, Show)

-- | Get the initial score for a normal game of tennis
newGame :: Score
newGame = Points Love Love

-- | Score a ball
score :: Score -- ^ The previous score
      -> Player -- ^ The ball-winning player
      -> Score -- ^ The score after this ball
score (Points Forty _) Player1 = Game Player1
score (Points _ Forty) Player2 = Game Player2
score _ Player1 = Points Fifteen Love
score _ Player2 = Points Love Fifteen

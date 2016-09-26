-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain types
    Score(..)
  , Point(..)
  , Player(..)
  -- * Advancing score
  , score
  ) where

-- | The players
data Player = Player1 | Player2
  deriving (Eq, Show, Enum, Bounded)

-- | Point
data Point = Love | Fifteen | Thirty | Forty
  deriving (Eq, Show, Enum, Bounded)

-- | The score in a game of tennis
data Score = Points Point Point
           | Game Player
           | Advantage Player
  deriving (Eq, Show)

-- | Advancing the score if a player wins a ball
score :: Player -- ^ The winnig player
      -> Score -- ^ The previous score
      -> Score -- ^ The resulting score
score p       (Advantage a)
  | a == p                         = Game p
score p       (Points Forty Forty) = Advantage p
score Player1 (Points Forty _)     = Game Player1
score Player2 (Points _ Forty)     = Game Player2
score _       _                    = Points Fifteen Love

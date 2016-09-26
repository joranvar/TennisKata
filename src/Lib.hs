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
  deriving Eq

-- | Point
data Point = Love | Fifteen | Thirty | Forty
  deriving (Eq, Show)

-- | The score in a game of tennis
data Score = Points Point Point
  deriving (Eq, Show)

-- | Advancing the score if a player wins a ball
score :: Player -- ^ The winnig player
      -> Score -- ^ The previous score
      -> Score -- ^ The resulting score
score _ _ = Points Fifteen Love

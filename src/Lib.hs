-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain types
    Score(..)
  , Player(..)
  , Point(..)
    -- * Exported functions
  , score
  ) where

-- | The state of the game of Tennis
data Score = LoveAll | Points Point Point | Advantage | Deuce | Winner Player
  deriving (Eq, Show)
-- | The point score
data Point = Love | Fifteen | Thirty | Forty
  deriving (Eq, Show)
-- | The player
data Player = Player1 | Player2
  deriving (Eq, Show)

-- | Advance the score after a ball
score :: Player -- ^ The winner of the ball
      -> Score -- ^ The previous score
      -> Score -- ^ The new score
score _ _ = LoveAll

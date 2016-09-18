-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Exported types
    Player(..)
  , Score(..)
  , Point(..)
    -- * Exported functions
  , score
  ) where

-- | A player in the game of Tennis
data Player = Player1 | Player2
  deriving (Eq, Show)
-- | The number of points before Advantage
data Point = Love | Fifteen | Thirty | Forty
  deriving (Eq, Show)
-- | The score at any point in the game of Tennis
data Score = Score
           | LoveAll
           | Winner Player
           | Points Point Point
  deriving (Eq, Show)

score :: [Player] -- ^ The players winning a ball
      -> Score    -- ^ The score after all the wins
score [] = LoveAll
score [w:ws] = advance score 

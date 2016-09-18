-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Exported types
    Player(..)
  , Score(..)
    -- * Exported functions
  , score
  ) where

-- | A player in the game of Tennis
data Player = Player1 | Player2
  deriving (Eq, Show)
-- | The score at any point in the game of Tennis
data Score = Score
           | LoveAll
           | Winner Player
  deriving (Eq, Show)

score :: [Player] -- ^ The players winning a ball
      -> Score    -- ^ The score after all the wins
score [] = LoveAll
score _ = Score

-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Exported types
    Score(..)
  , Player(..)
  , Point(..)
  -- * Exported functions
  , score
  ) where

-- | Possible points when not deuce or advantage
data Point = Love | Fifteen | Thirty | Forty
  deriving (Eq, Show)

-- | The player
data Player = Player1 | Player2
  deriving (Eq, Show)

-- | The current score
data Score = Winner Player
           | Advantage Player
           | Deuce
           | Points { player1::Point
                    , player2::Point }
  deriving (Eq, Show)

score :: [Player] -- ^ The players that won balls
      -> Score    -- ^ The score after that
score [] = Points Love Love
score [Player1] = Points Fifteen Love
score bs | length bs > 5 = Deuce
score _ = Points Love Fifteen

-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Exported types
    Score(..)
  , Player(..)
  , Point(..)
  ) where

-- | Possible points when not deuce or advantage
data Point = Love | Fifteen | Thirty | Forty

-- | The player
data Player = Player1 | Player2

-- | The current score
data Score = Winner Player
           | Advantage Player
           | Deuce
           | Points { player1::Point
                    , player2::Point }

-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain types
    Score(..)
  , Player(..)
  , Point(..)
    -- * Exported functions
  ) where

-- | The state of the game of Tennis
data Score = LoveAll | Points Point Point | Advantage | Deuce | Winner Player
-- | The point score
data Point = Love | Fifteen | Thirty | Forty
-- | The player
data Player = Player1 | Player2

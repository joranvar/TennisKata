-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain types
    Score(..)
  , Point(..)
  ) where

-- | Point
data Point = Love | Fifteen | Thirty | Forty

-- | The score in a game of tennis
data Score = Points Point Point

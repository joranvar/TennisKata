-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain types
    Score(..)
  , Point(..)
  ) where

data Score = Score Point Point

data Point = Love | Fifteen | Thirty | Forty

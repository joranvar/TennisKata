-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain types
    Score (..)
  , Points (..)
  ) where

data Score = Score Points Points
data Points = Love | Fifteen | Thirty | Forty

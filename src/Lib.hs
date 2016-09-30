-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain description
    Player(..)
  , Point(..)
  ) where

-- | Each player
data Player = Player1 | Player2
  deriving(Eq, Enum, Bounded, Show)

-- | can have either of these points
data Point = Love | Fifteen | Thirty | Forty
  deriving(Eq, Enum, Bounded, Show)

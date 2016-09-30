-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain description
    Player(..)
  , Point(..)
  , Game(..)

    -- * Predicates
  , isDeuce
  ) where

-- | Each player
data Player = Player1 | Player2
  deriving(Eq, Enum, Bounded, Show)

-- | can have either of these points
data Point = Love | Fifteen | Thirty | Forty
  deriving(Eq, Enum, Bounded, Show)

-- | in one game
data Game = Points Point Point
          | Winner Player
  deriving (Eq, Show)

-- | If both have 40 the players are deuce
isDeuce :: Game -> Bool
isDeuce = (== Points Forty Forty)

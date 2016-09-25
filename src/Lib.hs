-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain types
    Player (..)
  , Points (..)
  , Game (..)
  ) where

-- | Each player
data Player = Player1 | Player2
  deriving (Eq, Show, Enum, Bounded)

-- | can have either of these points
data Points = Love | Fifteen | Thirty | Forty
  deriving (Eq, Show, Enum, Bounded)

-- | in one game
data Game = Game { player1 :: Points
                 , player2 :: Points }

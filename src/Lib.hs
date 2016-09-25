-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain types
    Player (..)
  , Points (..)
  , Game (..)
    -- * The scoring function
  , score
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
          | Winner Player
  deriving (Eq, Show)

-- | Calculate what happens if a player scores
score :: Player -- ^ The scoring player
      -> Game   -- ^ The previous score
      -> Game   -- ^ The new score
score p _ = Winner p

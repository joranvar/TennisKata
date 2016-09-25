-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain types
    Player (..)
  , Points (..)
  , Game (..)
    -- * The scoring function
  , score
    -- * Util function
  , other
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
          | Advantage Player
  deriving (Eq, Show)

-- | Calculate what happens if a player scores
score :: Player -- ^ The scoring player
      -> Game   -- ^ The previous score
      -> Game   -- ^ The new score
score Player1 (Game p1 p2)
  | p1 /= Forty = Game (succ p1) p2
score Player2 (Game p1 p2)
  | p2 /= Forty = Game p1 (succ p2)
score p (Game Forty Forty) = Advantage p
score p (Advantage o)
  | o /= p = Game Forty Forty
score p _ = Winner p

-- | The other player
other :: Player -> Player
other Player1 = Player2
other Player2 = Player1

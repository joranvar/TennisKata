-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain description
    Player(..)
  , Point(..)
  , Game(..)

    -- * Main functions
  , score

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
          | Advantage Player
  deriving (Eq, Show)

-- | If both have 40 the players are deuce
isDeuce :: Game -> Bool
isDeuce = (== Points Forty Forty)

score :: Game -> Player -> Game
-- | If the game is in deuce, the winner of a ball will have advantage
score g winner | isDeuce g = Advantage winner
-- | If you have Forty and win the ball, you win the game
score (Points Forty _) Player1 = Winner Player1
score (Points _ Forty) Player2 = Winner Player2
-- | If the player with advantage wins the ball he wins the game
score (Advantage p) winner | winner == p = Winner winner
score _ _ = undefined

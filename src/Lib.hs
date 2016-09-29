-- | TennisKata - http://www.codingdojo.org/cgi-bin/index.pl?KataTennis
module Lib
  (
    -- * Domain description
    Player(..)
  , Points(..)
  , Game(..)
  , score
  ) where

-- | 1. Each player
data Player = Player1 | Player2
  deriving Eq

-- | can have either of these points in one game 0 15 30 40
data Points = Love | Fifteen | Thirty | Forty
  deriving (Enum, Bounded)

-- | (in one game)
data Game = Points Points Points
          | Winner Player
          | Advantage Player

-- | 2. If you have 40 and you win the ball you win the game,
-- | however there are special rules.
-- | 3. If both have 40 the players are deuce.
-- | a. If the game is in deuce, the winner of a ball will have advantage and game ball.
-- | b. If the player with advantage wins the ball he wins the game
-- | c. If the player without advantage wins they are back at deuce.
score :: Player -> Game -> Game
score p (Points Forty Forty) = Advantage p
score Player1 (Points Forty _) = Winner Player1
score Player2 (Points Forty _) = Winner Player2
score p (Advantage o) | p == o = Winner p
                      | otherwise = Points Forty Forty
score Player1 (Points p1 p2) = Points (succ p1) p2
score Player2 (Points p1 p2) = Points p1 (succ p2)
score _ (Winner p) = Winner p

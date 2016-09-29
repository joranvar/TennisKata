{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.SmallCheck
import Test.SmallCheck.Series

import Lib
instance (Monad m, Enum a, Bounded a) => Serial m a where
  series = generate (\d -> take d [minBound .. maxBound])

main :: IO ()
main = defaultMain $ testGroup "all-tests" tests

tests :: [TestTree]
tests =
  [ testGroup "SmallCheck" scTests
  , testGroup "\"Old\" tests" oldTests
  , testGroup "Unit tests" huTests
  ]

scTests :: [TestTree]
scTests =
  [ testProperty "Score never returns to Love-all" $
    \p ps -> foldl (flip score) (Points Love Love) (p:ps) /= (Points Love Love)
  , testProperty "The game gets a bit boring after six balls" $
    \p0 p1 p2 p3 p4 p5 ps ->
      foldl (flip score) (Points Love Love) (p0:p1:p2:p3:p4:p5:ps) `elem`
      [ Points Forty Forty
      , Advantage Player1
      , Winner Player1
      , Advantage Player2
      , Winner Player2 ]
  ]

pointsFor :: Player -> Points -> Points -> Game
pointsFor Player1 p1 p2 = Points p1 p2
pointsFor Player2 p2 p1 = Points p1 p2

other :: Player -> Player
other Player1 = Player2
other Player2 = Player1

oldTests :: [TestTree]
oldTests =
  [ testProperty "Score advances unless it is Forty" $
    \player p1 p2 -> Forty `notElem` [p1,p2] ==> score player (pointsFor player p1 p2) == (pointsFor player (succ p1) p2)
  , testProperty "Player with Forty scores, then wins" $
    \player p2 -> Forty `notElem` [p2] ==> score player (pointsFor player Forty p2) == Winner player
  , testProperty "Player who wins at deuce gains advantage" $
    \player -> score player (Points Forty Forty) == Advantage player
  , testProperty "If advantaged player wins -> Game for that player" $
    \player -> score player (Advantage player) == Winner player
  , testProperty "If non-advantaged player wins -> Deuce" $
    \player -> score player (Advantage $ other player) == Points Forty Forty
  ]

huTests :: [TestTree]
huTests =
  [ testCase "True is True" $
    True @?= True
  ]

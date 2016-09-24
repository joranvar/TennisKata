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
  , testGroup "Unit tests" huTests
  ]

scTests :: [TestTree]
scTests =
  [ testProperty "Scoring when both players are < 40 adds points to the winner's score" $
    \player p q -> p /= Forty && q /= Forty ==> score player (Points p q) == case player of
      Player1 -> Points (succ p) q
      Player2 -> Points p (succ q)
  , testProperty "Scoring when player has forty -> player wins the game" $
    \p -> and [ score Player1 (Points Forty p) == Game Player1
             , score Player2 (Points p Forty) == Game Player2
             ]
  , testProperty "Scoring when deuce gives player advantage" $
    \p -> score p Deuce == Advantage p
  ]

huTests :: [TestTree]
huTests =
  [ testCase "Scoring when player has thirty and other player has forty -> deuce" $
    score Player1 (Points Thirty Forty) @?= Deuce
  , testCase "Scoring when player has thirty and other player has forty -> deuce" $
    score Player2 (Points Forty Thirty) @?= Deuce
  ]

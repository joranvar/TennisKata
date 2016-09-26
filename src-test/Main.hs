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
  [ testProperty "Player with 40 points who scores, wins (unless deuce) (p1)" $
    \p -> p /= Forty ==> score Player1 (Points Forty p) == Game Player1
  , testProperty "Player with 40 points who scores, wins (p2)" $
    \p -> p /= Forty ==> score Player2 (Points p Forty) == Game Player2
  , testProperty "When deuce, player who scores, gets advantage" $
    \p -> score p (Points Forty Forty) == Advantage p
  , testProperty "When advantage and advantaged player scores, wins" $
    \p -> score p (Advantage p) == Game p
  , testProperty "When advantage and other player scores -> deuce" $
    \p -> score p (Advantage (other p)) == Points Forty Forty
  , testProperty "When player scores and none has forty, they advance points (p1)" $
    \p1 p2 -> p1 /= Forty && p2 /= Forty ==> score Player1 (Points p1 p2) == Points (succ p1) p2
  , testProperty "When player scores and none has forty, they advance points (p2)" $
    \p1 p2 -> p1 /= Forty && p2 /= Forty ==> score Player2 (Points p1 p2) == Points p1 (succ p2)
  ]

huTests :: [TestTree]
huTests =
  [ testCase "Love-all and Player1 scores -> Fifteen-Love" $
    score Player1 (Points Love Love) @?= Points Fifteen Love
  ]

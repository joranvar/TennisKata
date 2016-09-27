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
  [ testProperty "Player with Forty scores / other is not Forty -> wins (p1)" $
    \otherScore -> otherScore /= Forty ==> score Player1 (Score Forty otherScore) == Game Player1
  , testProperty "Player with Forty scores -> wins (p2)" $
    \otherScore -> otherScore /= Forty ==> score Player2 (Score otherScore Forty) == Game Player2
  , testProperty "Both Forty, player scores -> advantage for player" $
    \player -> score player (Score Forty Forty) == Advantage player
  , testProperty "Advantaged player scores -> wins" $
    \player -> score player (Advantage player) == Game player
  , testProperty "Non-advantaged player scores -> deuce" $
    \player -> score player (Advantage $ other player) == Score Forty Forty
  ]

huTests :: [TestTree]
huTests =
  [ testCase "True is True" $
    True @?= True
  ]

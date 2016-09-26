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
  [ testProperty "Player with 40 points who scores, wins" $
    \p -> score Player1 (Points Forty p) == Game Player1
  ]

huTests :: [TestTree]
huTests =
  [ testCase "Love-all and Player1 scores -> Fifteen-Love" $
    score Player1 (Points Love Love) @?= Points Fifteen Love
  ]

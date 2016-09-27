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
  [ testProperty "Player with Forty scores -> wins (p1)" $
    \otherScore -> score Player1 (Score Forty otherScore) == Game Player1
  , testProperty "Player with Forty scores -> wins (p2)" $
    \otherScore -> score Player2 (Score otherScore Forty) == Game Player2
  ]

huTests :: [TestTree]
huTests =
  [ testCase "True is True" $
    True @?= True
  ]

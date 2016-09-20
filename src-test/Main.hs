{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.SmallCheck
import Test.SmallCheck.Series

import Lib
instance (Monad m) => Serial m Player where
  series = generate (\d -> take d [Player1, Player2])

main :: IO ()
main = defaultMain $ testGroup "all-tests" tests

tests :: [TestTree]
tests =
  [ testGroup "SmallCheck" scTests
  , testGroup "Unit tests" huTests
  ]

scTests :: [TestTree]
scTests =
  [ testProperty "Scoring at least one ball: no longer Love all" $
    \ball balls -> score (ball:balls) /= Points Love Love
  ]

huTests :: [TestTree]
huTests =
  [ testCase "Scoring no balls: Love all" $
    score [] @?= Points Love Love
  ]

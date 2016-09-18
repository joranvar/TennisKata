{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.SmallCheck
import Test.SmallCheck.Series

import Lib (score, Player(..), Score(..))
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
  [ testProperty "Any game can be scored" $
    \wins -> score wins `elem` [Score, LoveAll]
  ]

huTests :: [TestTree]
huTests =
  [ testCase "It starts with nothing" $
    score [] @?= LoveAll
  ]

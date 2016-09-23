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
  [ testProperty "Player1 scores and both do not have 40 -> Player1 gets higher score" $
    \p q -> p /= Forty && q /= Forty ==> score Player1 (Points p q) == Points (succ p) q
  , testProperty "Player2 scores and both do not have 40 -> Player2 gets higher score" $
    \p q -> p /= Forty && q /= Forty ==> score Player2 (Points p q) == Points p (succ q)
  , testProperty "Player1 scores and does have 40 -> Player1 wins" $
    \p -> score Player1 (Points Forty p) == Game Player1
  , testProperty "Player2 scores and does have 40 -> Player2 wins" $
    \p -> score Player2 (Points p Forty) == Game Player2
  ]

huTests :: [TestTree]
huTests =
  [ testCase "Player1 scores at Thirty Forty -> Deuce" $
    score Player1 (Points Thirty Forty) @?= Deuce
  , testCase "Player2 scores at Forty Thirty -> Deuce" $
    score Player2 (Points Forty Thirty) @?= Deuce
  ]

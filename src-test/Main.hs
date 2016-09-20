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
  , testProperty "Scoring at least six balls: deuce, advantage or winner" $
    \b0 b1 b2 b3 b4 b5 balls -> score (b0:b1:b2:b3:b4:b5:balls) `elem` [Deuce, Advantage Player1, Advantage Player2, Winner Player1, Winner Player2]
  , testProperty "Only Player1 scores: x - Love, Deuce, Advantage P1 or winner P1" $
    \x -> noP2 $ score (replicate x Player1)
  ]
  where noP2 (Points _ Love) = True
        noP2 (Deuce) = True
        noP2 (Advantage Player1) = True
        noP2 (Winner Player1) = True
        noP2 _ = False

huTests :: [TestTree]
huTests =
  [ testCase "Scoring no balls: Love all" $
    score [] @?= Points Love Love
  , testCase "Scoring one ball p1: fifteen - love" $
    score [Player1] @?= Points Fifteen Love
  , testCase "Scoring one ball p2: love - fifteen" $
    score [Player2] @?= Points Love Fifteen
  , testCase "Scoring two balls p1: thirty - love" $
    score [Player1, Player1] @?= Points Thirty Love
  ]

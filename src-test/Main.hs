{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.SmallCheck
import Test.SmallCheck.Series

import Lib (score, Player(..), Score(..), Point(..))
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
  , testProperty "A game with three balls is not won" $
    \(win0, win1, win2) -> score [win0, win1, win2] `notElem` [Winner Player1, Winner Player2]
  , testProperty "First winner gets the points" $
    \win -> score [win] `elem` [Points Love Fifteen, Points Fifteen Love]
  ]

huTests :: [TestTree]
huTests =
  [ testCase "It starts with nothing" $
    score [] @?= LoveAll
  ]

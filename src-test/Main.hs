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
  [ testProperty "After one ball, score is Fifteen-Love or Love-Fifteen" $
    \ball -> score newGame ball `elem` [Points Fifteen Love, Points Love Fifteen]
  ]

huTests :: [TestTree]
huTests =
  [ testCase "An empty game is Love-all" $
    newGame @?= Points Love Love
  , testCase "After one ball for player 1, score is Fifteen-Love" $
    score newGame Player1 @?= Points Fifteen Love
  ]

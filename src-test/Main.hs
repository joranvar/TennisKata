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
  , testProperty "When Forty-<anything but forty> and ball for player 1, score is Game for player 1" $
    \points ->
      case points of
        Forty -> True
        _ -> score (Points Forty points) Player1 == Game Player1
  , testProperty "When <anything but forty>-Forty and ball for player 2, score is Game for player 2" $
    \points ->
      case points of
        Forty -> True
        _ -> score (Points points Forty) Player2 == Game Player2
  ]

huTests :: [TestTree]
huTests =
  [ testCase "An empty game is Love-all" $
    newGame @?= Points Love Love
  , testCase "After one ball for player 1, score is Fifteen-Love" $
    score newGame Player1 @?= Points Fifteen Love
  , testCase "After one ball for player 2, score is Love-Fifteen" $
    score newGame Player2 @?= Points Love Fifteen
  , testCase "When Forty-Thirty and ball for player 1, score is Game for player 1" $
    score (Points Forty Thirty) Player1 @?= Game Player1
  ]

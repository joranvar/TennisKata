{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.SmallCheck
import Test.SmallCheck.Series

import Lib
instance (Monad m, Bounded a, Enum a) => Serial m a where
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
  [ testProperty "Player1 has Forty and wins the ball -> Game Player1" $
    \p -> score Player1 (Points Forty p) == Game Player1
  , testProperty "Player2 has Forty and wins the ball -> Game Player2" $
    \p -> score Player2 (Points p Forty) == Game Player2
  , testProperty "Deuce -> winner gets advantage" $
    \p -> score p Deuce == Advantage p
  , testProperty "Advantaged player scores -> Game for that player" $
    \p -> score p (Advantage p) == Game p
  , testProperty "Other than advantaged player scores -> Deuce" $
    \p -> score (other p) (Advantage p) == Deuce
  , testProperty "Neither has forty points and player1 wins -> Player1 has succ of what she had" $
    \p q -> p /= Forty && q /= Forty ==> score Player1 (Points p q) == Points (succ p) q
  ]

huTests :: [TestTree]
huTests =
  [ testCase "True is True" $
    True @?= True
  ]

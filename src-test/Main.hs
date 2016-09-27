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
  [ testProperty "Player with Forty scores / other is not Forty -> wins (p1)" $
    \otherScore -> otherScore /= Forty ==> score Player1 (Score Forty otherScore) == Game Player1
  , testProperty "Player with Forty scores -> wins (p2)" $
    \otherScore -> otherScore /= Forty ==> score Player2 (Score otherScore Forty) == Game Player2
  , testProperty "Both Forty, player scores -> advantage for player" $
    \player -> score player (Score Forty Forty) == Advantage player
  , testProperty "Advantaged player scores -> wins" $
    \player -> score player (Advantage player) == Game player
  , testProperty "Non-advantaged player scores -> deuce" $
    \player -> score player (Advantage $ other player) == Score Forty Forty
  , testProperty "Any other score -> player advances (p1)" $
    \p1 p2 -> Forty `notElem` [p1,p2] ==> score Player1 (Score p1 p2) == Score (succ p1) p2
  , testProperty "Any other score -> player advances (p2)" $
    \p1 p2 -> Forty `notElem` [p1,p2] ==> score Player2 (Score p1 p2) == Score p1 (succ p2)
  ]

huTests :: [TestTree]
huTests =
  [ testCase "True is True" $
    True @?= True
  ]

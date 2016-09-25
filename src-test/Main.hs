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
  [ testProperty "If you have 40 and you win the ball you win the game - p1" $
    \p1 -> score Player2 (Game { player1 = p1, player2 = Forty}) == Winner Player2
  , testProperty "If you have 40 and you win the ball you win the game - p2" $
    \p2 -> score Player1 (Game { player2 = p2, player1 = Forty}) == Winner Player1
  , testProperty "Win a ball if you don't have 40, you will advance a point - p1" $
    \p1 p2 -> p1 /= Forty ==> score Player1 (Game { player1 = p1, player2 = p2}) == Game { player1 = succ p1, player2 = p2 }
  , testProperty "Win a ball if you don't have 40, you will advance a point - p2" $
    \p1 p2 -> p2 /= Forty ==> score Player2 (Game { player1 = p1, player2 = p2}) == Game { player1 = p1, player2 = succ p2 }
  ]

huTests :: [TestTree]
huTests =
  [ testCase "True is True" $
    True @?= True
  ]

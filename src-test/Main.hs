{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.SmallCheck
import Test.SmallCheck.Series

import Lib
instance (Monad m) => Serial m Player where
  series = generate (\d -> take d [ Player1, Player2 ])

main :: IO ()
main = defaultMain $ testGroup "all-tests" tests

tests :: [TestTree]
tests =
  [ testGroup "SmallCheck" scTests
  , testGroup "Unit tests" huTests
  ]

scTests :: [TestTree]
scTests =
  [ testProperty "No love-all after any ball" $
    \ball -> score ball LoveAll /= LoveAll
  , testProperty "One ball after love-all has a fifteen" $
    \ball -> score ball LoveAll `elem` [Points Fifteen Love, Points Love Fifteen]
  , testProperty "Advantaged player wins ball -> wins game" $
    \ball -> score ball (Advantage ball) == Winner ball
  ]

huTests :: [TestTree]
huTests =
  [ testCase "Player two win after love-all -> Love Fifteen" $
    score Player2 LoveAll @?= Points Love Fifteen
  ]

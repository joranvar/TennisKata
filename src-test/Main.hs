{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.SmallCheck
--import Test.SmallCheck.Series

import Lib
-- instance (Monad m) => Serial m T where
--   series = generate (\d -> take d [ ])

main :: IO ()
main = defaultMain $ testGroup "all-tests" tests

tests :: [TestTree]
tests =
  [ testGroup "SmallCheck" scTests
  , testGroup "Unit tests" huTests
  ]

scTests :: [TestTree]
scTests =
  [ testProperty "id x == x" $
    \x -> id (x::Int) == x
  ]

huTests :: [TestTree]
huTests =
  [ testCase "Scoring no balls: Love all" $
    score [] @?= Points Love Love
  ]

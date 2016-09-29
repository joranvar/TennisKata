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
  [ testProperty "Score never returns to Love-all" $
    \p ps -> foldl (flip score) (Points Love Love) (p:ps) /= (Points Love Love)
  , testProperty "The game gets a bit boring after six balls" $
    \p0 p1 p2 p3 p4 p5 ps ->
      foldl (flip score) (Points Love Love) (p0:p1:p2:p3:p4:p5:ps) `elem`
      [ Points Forty Forty
      , Advantage Player1
      , Winner Player1
      , Advantage Player2
      , Winner Player2 ]
  ]

huTests :: [TestTree]
huTests =
  [ testCase "True is True" $
    True @?= True
  ]

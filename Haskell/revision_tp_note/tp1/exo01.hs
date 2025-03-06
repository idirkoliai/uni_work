module Main where

main :: IO ()
main = print result
  where
    x = 5
    y = 7
    z = 4
    multiple = min x y ^ 2 + 1
    notmultiple = min x y ^ 2
    result = if z `mod` 3 == 0 then multiple else notmultiple
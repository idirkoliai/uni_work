fibonacciSeq2 :: [Integer]
fibonacciSeq2 = 0 : 1 : [x + y | (x, y) <- zip fibonacciSeq2 $ tail fibonacciSeq2]


fibonacciSeq2' :: [Integer]
fibonacciSeq2' = fibs 0 1
  where
    fibs x y = x : fibs y (x + y)


fibonacciSeq3 :: [Integer]
fibonacciSeq3 = map fst $ iterate(\(x,y) -> (y,x+y)) (0,1)
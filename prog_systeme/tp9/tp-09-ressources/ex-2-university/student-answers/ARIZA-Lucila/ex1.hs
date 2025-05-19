properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n], n `mod` x == 0, x < n]

perfects :: Int -> [Int]
perfects n 
    |sum (properFactors n) /= n = []
    |otherwise = properFactors n 


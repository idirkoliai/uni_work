isEven :: (Integral a) => a -> Bool
isEven 0 = True
isEven n = isOdd (n - 1)

isOdd :: (Integral a) => a -> Bool
isOdd 0 = False
isOdd n = isEven (n - 1)


isEvenOddAlternating :: Integral a => [a] -> Bool
isEvenOddAlternating [] = True
isEvenOddAlternating [x] = even x
isEvenOddAlternating (x:xs) = even x && isOddEvenAlternating xs 

isOddEvenAlternating :: Integral a => [a] -> Bool
isOddEvenAlternating [] = True
isOddEvenAlternating [x] = odd x
isOddEvenAlternating (x:xs) = odd x && isEvenOddAlternating xs

isAlternating :: Integral a => [a] -> Bool
isAlternating xs = isOddEvenAlternating xs || isEvenOddAlternating xs
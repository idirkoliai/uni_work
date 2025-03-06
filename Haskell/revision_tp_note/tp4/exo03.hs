import Data.List

boundedSumOddSquare :: Int -> Int
boundedSumOddSquare k = sum $ filter odd $ takeWhile (<= k) $ map (^ 2) [1..]

foldIntermediateR :: (a -> b -> b) -> b -> [a] -> [b]
foldIntermediateR _ acc [] = [acc]
-- foldr f acc xs : foldIntermediateR f acc xs'
foldIntermediateR f acc xs@(x : xs') = f x (head rest) : rest
  where
    rest = foldIntermediateR f acc xs'

foldIntermediateL :: (b -> a -> b) -> b -> [a] -> [b]
foldIntermediateL _ acc [] = [acc]
-- foldIntermediateL f acc (init xs) ++ [foldl f acc xs]
foldIntermediateL f acc xs@(x : xs') = acc : foldIntermediateL f (f acc x) xs'

moveZeros :: [Int] -> [Int]
moveZeros xs = filtred ++ replicate k 0
  where
    filtred = filter (/= 0) xs
    k = length $ filter (== 0) xs

spinWords :: String -> String
spinWords str = unwords [processed x | x <- words str]
  where
    processed x
      | length x >= 5 = reverse x
      | otherwise = x


uncurry :: (a -> b -> c) -> (a, b) -> c
uncurry f (x,y) = f x y
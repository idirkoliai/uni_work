import Data.Char

intercalate' :: [a] -> [[a]] -> [a]
intercalate' [] xss = concat xss
intercalate' _ [] = []
intercalate' _ [x] = x
intercalate' separator (xs : xss) = xs ++ separator ++ intercalate' separator xss

words' :: String -> [String]
words' [] = []
words' xs = filter (not . null) $ takeWhile (not . isSpace) (dropWhile isSpace xs) : words' (dropWhile (not . isSpace) (dropWhile isSpace xs))

unwords' :: [String] -> String
unwords' = intercalate' " "

oneOutOfEveryTwo :: [a] -> [a]
oneOutOfEveryTwo = reverse . snd . foldl (\(flag, acc) x -> if flag then (not flag, x : acc) else (not flag, acc)) (True, [])

oneOutOfEveryK :: Int -> [a] -> [a]
oneOutOfEveryK k = reverse . snd . foldl (\(count, acc) x -> if (count `mod` k) == 0 then (succ count, x : acc) else (succ count, acc)) (0, [])

cycle' :: [a] -> [a]
cycle' [] = error "siuu"
cycle' xs = xs ++ cycle' xs

sumOddsEvens :: [Int] -> (Int, Int)
sumOddsEvens = foldr (\x (evens, odds)  -> if even x then (evens, x + odds) else (x + evens, odds)) (0, 0)

withAtLeastKLetters :: [String] -> Int -> [String]
withAtLeastKLetters xs k = [x | x <- xs, length x >= k]

withAtLeastKVowels :: [String] -> Int -> [String]
withAtLeastKVowels xs k = [x | x <- xs, hasKVowels x ]
    where 
        hasKVowels x = k <= length  (filter (\x'-> x' `elem` ['a','e','i','o','u','y']) x)


increasingEvenPairs :: Int -> Int -> [(Int, Int)]
increasingEvenPairs inf supp = [(x,x') | x <- range ,x' <- range' x ,even $ x+x' ]
    where 
        range = [inf..supp]
        range' x =[x+1..supp]
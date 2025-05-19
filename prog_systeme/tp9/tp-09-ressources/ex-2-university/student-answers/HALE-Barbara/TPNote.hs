import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], n `mod` x == 0 ]

perfects :: Int -> [Int]
perfects n = [x | x <- [1.. n-1], sum (properFactors x) == x]

--fizzBuzz :: [String]
--fizzBuzz = [x | x <- [1..], x == 3 ]

-- fizzBuzz = [x | x <- [1..], if ((mod x 3) == 0) then "fizz" else  if ((mod x 5) == 0) then "buzz" else show (x)]


--diffParity :: Int -> Int -> Int -> Bool
--diffParity x y z 
--    | even x and even y and even z = False
--    | odd x and odd y and odd z = False
--    | otherwise = True

--altParity3 :: Int -> Int -> [(Int, Int, Int)]
--altParity3 fromN toN = [(x, y, z) | x <- [fromN..toN], y <- [fromN..toN], z <- [x+1..toN], or [(y /=z), (y /= x)], diffParity x y z ]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] =  False 
any' p (x:xs) 
    | p x = True
    | otherwise = any' p xs

--any'' :: (a -> Bool) -> [a] -> Bool
--any'' p = foldr (\b x -> if p x then True else False)

-- group' :: Eq a => [a] -> [[a]]

--while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while p f x0 = takeWhile

-- syracuse :: Int -> [Int]




--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = []
cycle' x = x ++ cycle' x

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI i1 i2 = let (x, x') = i1 in let (y, y') = i2 in or [(x `elem` [y..y']), (y `elem` [x..x'])]

diff :: (Int, Int) -> Int
diff  x = let (z, z') = x in (z' - z)

unitI :: [(Int, Int)] -> Bool

unitI ys = go ys 
    where 
        go [] = True
        go (x:xs) 
            | diff x == diff (head(xs)) = go xs
            | otherwise = False

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

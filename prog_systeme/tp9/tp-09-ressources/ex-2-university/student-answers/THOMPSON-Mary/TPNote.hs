import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors 0 = [0]
properFactors n = [x | x <- [1..n], n `mod` x == 0, x < n]

perfects :: Int -> [Int]
perfects 0 = []
perfects n = [x | x <- [1..n], estparfait x]
    where estparfait :: Int -> Bool
          estparfait 0 = False
          estparfait m = if sum(properFactors m) == m then True else False

--fizzBuzz :: [String]
--fizzBuzz = [Show x | x <- [1..], x ]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 n m = [(x, y, z) | x <- [n..m], y <- [n..m], z <- [n..m], z < x, diff y x z, not (x `mod` 2 == 0 && y `mod` 2 == 0 && z `mod` 2 == 0) && not (x `mod` 2 /= 0 && y `mod` 2 /= 0 && z `mod` 2 /= 0)]
    where diff :: Int -> Int -> Int -> Bool
          diff a b c = if a /= b || a /= c then True else False

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs) = if p x then True else any' p xs

-- any'' :: (a -> Bool) -> [a] -> Bool


-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

--borders :: (Eq a) => [a] -> [[a]]
--borders [x] = [[], [x]]
--borders (x:xs) = 

--sublists :: Int -> [a] -> [[a]]
--sublists 0 _ = [[]]
--sublists n xs = 

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x1, y1) (x2, y2) = if (x1 < x2 && y1 < x2) || (x2 < x1 && y2 < x1) then False else True
    

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [(x, y)] = True
unitI (x:xs:xss) = if longueur x /= longueur xs then False else unitI xss
    where longueur :: (Int, Int) -> Int
          longueur (n, m) = m-n

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

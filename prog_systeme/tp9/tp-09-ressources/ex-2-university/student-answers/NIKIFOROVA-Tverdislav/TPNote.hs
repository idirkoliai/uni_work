import           Data.List as L


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [xs | xs <- [1..n-1], n `mod` xs == 0]

perfects :: Int -> [Int]
perfects n = [y | y <- [1..n-1], L.sum (properFactors y) == y]

-- fizzBuzz :: [String]

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs)
 | p x == True = True
 | otherwise = any' p xs

-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0
 | p x0 == True = x0 : while p f (f x0)
 | otherwise = []

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs


-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

select :: [a] -> [(a, [a])]
select [] = []
select (x:[]) = [(x, [])]
select (x:xs) = select [x] ++ select xs

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x1, y1) (x2, y2)
 | (x1 <= x2 && x2 <= y1) ||  (x1 >= x2 && x1 <= y2) = True
 | otherwise = False

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI ((x1, y1):[]) = True
unitI ((x1, y1) : (x2,y2) : xs)
 | y1 - x1 == y2 - x2 = unitI ((x2,y2) : xs)
 | otherwise = False

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI ((x1, y1):[]) = True
isLeftSortedI ((x1, y1) : (x2,y2) : xs)
 | x1 <= x2 = isLeftSortedI ((x2,y2) : xs)
 | otherwise = False

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (x1, y1) (x2, y2) = (min x1 x2, max y1 y2)

coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [] = []
coversLeftSortedI ((x1, y1):[]) = [(x1, y1)]
coversLeftSortedI (x1 : x2 : xs)
 | intersectI x1 x2 == True = coverI x1 x2 : coversLeftSortedI (x2 : xs)
 | otherwise = x1 : x2 : coversLeftSortedI (x2 : xs)

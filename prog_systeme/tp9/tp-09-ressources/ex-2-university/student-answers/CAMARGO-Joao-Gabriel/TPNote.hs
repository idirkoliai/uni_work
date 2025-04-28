import           Data.List


--
-- Exercice 1
-- 
properFactors :: Int -> [Int]
properFactors x = [y|y <- [0..x],z <-[0..x], y * z == x, y /= x]


perfects :: Int -> [Int]
perfects x = [y|y <- [0..x],sum(properFactors y) == y]

-- fizzBuzz :: [String]


--altParity3 :: Int -> Int -> [(Int, Int, Int)]



--
-- Exercice 2
--

--any' :: (a -> Bool) -> [a] -> Bool


-- any'' :: (a -> Bool) -> [a] -> Bool

group' :: Eq a => [a] -> [[a]]
group'[] = []
--group (x:y:xs) = 

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = error "liste vide"
cycle' xs = xs ++ cycle' xs

--borders :: (Eq a) => [a] -> [[a]]
--borders [] = [""]


-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x,y) (z,w) =  x > z && x < w || y > z && y < w


unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [x] = True
unitI [(a,b),(c,d)] = a - b == c - d 




isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [(a,b)] = a<b
isLeftSortedI [(a,b),(c,d)] = a<b && c<d 



--coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)


-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

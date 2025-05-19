import           Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]
-- properFactors n = [f | f <- [1..n-1], n `div` f]


-- perfects :: Int -> [Int]
-- perfetcs n = [p | p <- [0..n], p == sum properFactors p]


-- fizzBuzz :: [String]
-- fizzbuzz = [f | f <- [0..], f


-- altParity3 :: Int -> Int -> [(Int, Int, Int)]
-- altParity3 f t = [(x,y,z) | () , z < x, y /= z or y /= x]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs) = if p x then True else any' p xs

-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]
-- while p f x0 = if p f x0 then x0 ++ while p f (f x0) else []


-- syracuse :: Int -> [Int]
-- syracuse 1 = [1]
-- syracuse k = if even k then k = [div k 2] ++ (syracuse k-1) else [k * 3 + 1] ++ (syracuse k-1)

loop :: Int -> (a -> a) -> a -> [a]
loop 0  f x0 = []
loop k f x0 = [x0] ++ loop (k-1) f (f x0)

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

-- borders :: (Eq a) => [a] -> [[a]]



-- sublists :: Int -> [a] -> [[a]]
-- sublists k xs = [xs | 


-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x1, x2) (y1, y2) = if (x2 > y1 && x2 < y2) || (y2 > x1 && y2 < x1) || (x1 < y1 && x1 < y2 && x2 > y1 && x2 > y2) || (y1 < x1 && y1 < x2 && y2 > x1 && y2 > x2) then True else False 


-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..(n-1)], n `mod` x == 0]

perfects :: Int -> [Int]
perfects x = [x' | x' <- [1..x], x' == sum (properFactors x')]


-- fizzBuzz :: [String]
-- fizzBuzz = [x' | x' <- [1..], if x' `mod` 3 == 0 && x' `mod` 5 == 0 then "fizzbuzz" else if x' `mod` 3 == 0 then "fizz" else if x' `mod` 5 == 0 then "buzz" else show x']

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 x y = [(x',y',z') | x' <- [x..y], y' <- [x..y], z' <- [x..y], z' < x', y' /= x' || y' /= z', (x' `mod` 2 == 0 && (y' `mod` 2 == 1 || z' `mod` 2 == 1)) || (y' `mod` 2 == 0 && (x' `mod` 2 == 1 || z' `mod` 2 == 1)) || (z' `mod` 2 == 0 && (x' `mod` 2 == 1 || y' `mod` 2 == 1))]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' f [] = True
any' f [x] = if f x then True else False
any' f (x : xs) = if f x || any' f xs then True else False

-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = if p x0 then x0 : while p f (f x0) else []

-- syracuse :: Int -> [Int]
-- syracuse 1 = [1]
-- syracuse x = if x `mod` 2 == 0 then let rep = (while even (/2) x) in rep : syracuse (head (reverse rep)) else let rep = (while even ((*3) + 1) x) in rep : syracuse (head (reverse rep))

-- loop :: Int -> (a -> a) -> a -> [a]
-- loop 0 f x0 = []
-- loop k f x0 = (k* (f x0)) : loop (k-1) f x0


--
-- Exercice 3
--

-- cycle' :: [a] -> [a]
-- cycle' [x] = cycle' [x, x]

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]
-- select [] = []
-- select [x] = [(x, [])]
-- select (x : xs) = [(x,)]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

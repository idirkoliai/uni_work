import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], mod n x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], (sum (properFactors x)) == x]

-- fizzBuzz :: [String]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x, y /= x || y /= z]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs)
    | p x = True
    | otherwise = any' p xs

-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]
-- group' [] = [[]]
-- group' [a] = [[a]]
-- group' (x:y:xs)

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = takeWhile (p) (iterate f x0)

auxSyracuse :: Int -> Int
auxSyracuse n
    | even n = div n 2
    | otherwise = n * 3 + 1

syracuse :: Int -> [Int]
syracuse n = while (\n -> n /= 1) auxSyracuse n

loop :: Int -> (a -> a) -> a -> [a]
loop n f x0
    | n == 0 = []
    | otherwise = [x0] ++ loop (n - 1) f (f x0)

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle xs

-- borders :: (Eq a) => [a] -> [[a]]

auxSublists :: [a] -> [[a]]
auxSublists [] = [[]]
auxSublists (x:xs) = xss ++ map (x:) xss
    where
        xss = auxSublists xs

sublists :: Int -> [a] -> [[a]]
sublists k = filter ((==) k . length) . auxSublists

-- select :: [a] -> [(a, [a])]
-- select [] = []
-- select xs = [(x, y) | x <- xs, y <- sublists ((length xs) - 1) xs, elem x y == False]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x1, x1') (x2, x2') = ((x1 >= x2) && (x1 <= x2')) || ((x1' >= x2) && (x1' <= x2'))


-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

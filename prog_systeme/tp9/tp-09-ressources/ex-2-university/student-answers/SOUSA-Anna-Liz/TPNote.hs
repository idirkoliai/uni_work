import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors x = [y | y <- [1..x-1], x `mod` y == 0]

perfects :: Int -> [Int]
perfects x = [x | x <- [1..x], x == sum (properFactors x)]

-- fizzBuzz :: [String]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN],
                                    (x >= fromN) && (x <= toN),
                                    (y >= fromN) && (y <= toN),
                                    (z >= fromN) && (z <= toN),
                                    z < x,
                                    (y /= x) || (y /= z),
                                    ((odd x && odd y && odd z) == False) && ((even x && even y && even z) == False)]


--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool

-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' x = x ++ cycle' x

-- fonction non finie
-- borders :: (Eq a) => [a] -> [[a]]
-- borders [] = []
-- borders x = x : borders (init (tail x))

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (a,b) (c,d) = if (c <= b) && (d >= a) then True else if (c <= a) && (d >= a) then True else False

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [x] = True
unitI (x:xs:xss) = (if (snd x - fst x) == (snd xs - fst xs) then True else False) && unitI (xs:xss)

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

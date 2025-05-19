import           Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]

properFactors :: Int -> [Int]
properFactors 0 = []
properFactors x = [n | n <- [1..x] , n /= x, x `mod` n == 0 ]

-- perfects :: Int -> [Int]

-- fizzBuzz :: [String]

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 f t = [(x,y,z) | x <- [f..t], y <- [f..t], z <- [f..t], z < x, y /= x || y /= z, even x /= even y || even x /= even z || even y /= even z ]


--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x : xs)
   | p x = True
   | otherwise = any' p xs 

-- any'' :: (a -> Bool) -> [a] -> Bool



-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0
   | p x0 = [x0] ++ while p f x1
   | otherwise = []
     where
       x1 = f x0

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)

loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ x0 = []
loop k f x0 = [x0] ++ loop (k-1) f (f x0)

--
-- Exercice 3
--

-- cycle' :: [a] -> [a]

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

-- borders :: (Eq a) => [a] -> [[a]]

borders :: (Eq a) => [a] -> [[a]]
borders xs = [b | b <- (tails xs) , b == take (length b) xs, b == drop (length xs - length b) xs ]


-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]


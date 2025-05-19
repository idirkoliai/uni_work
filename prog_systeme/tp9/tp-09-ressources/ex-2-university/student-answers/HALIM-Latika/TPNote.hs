import           Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n], mod n x == 0 && n /= x]  

-- perfects :: Int -> [Int]
perfects n = [x | x <- [1..n],sum(properFactors x) == x ]

-- fizzBuzz :: [String]
fizzBuzz = [x | x <- [1..]]


-- altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN .. toN], y <- [fromN..toN],z <- [fromN..toN], z < x , y /= x || y/=z]



--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool
any' _[] = False
any' p (x:xs) = if p x then True else any' p xs

-- any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr(\x acc -> if p x then True else False) False xs 

-- group' :: Eq a => [a] -> [[a]]
group' a = foldr(\x acc -> if x == head acc then x:acc else [x]++acc)[head a] a

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0
    |p x0 = x0:while p f (f x0)
    |otherwise = []

-- syracuse :: Int -> [Int]
syracuse a = while (\x -> x/=1)(\x -> if mod x 2 == 0 then (head x `div` 2):[x] else (head x * 3 +1):[x])a

-- loop :: Int -> (a -> a) -> a -> [a]


--
-- Exercice 3
--

-- cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]
sublists 0 [] = [[]]
sublists _[] = []
sublists k (x:xs)
    |k <0 =[]
    |otherwise = map(x:)(sublists (k-1) xs)++sublists k xs

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

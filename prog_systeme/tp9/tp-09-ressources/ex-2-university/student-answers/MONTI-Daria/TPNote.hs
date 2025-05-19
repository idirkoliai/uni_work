import Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors k = [x | x <- [1..k-1], mod k x == 0]


perfects :: Int -> [Int]
perfects k = [x | x <- [1..k], sum (properFactors x) == x]

fizzBuzz :: [String]
fizzBuzz = [f x | x <- [1..]]
    where 
        f x = if mod x 3 == 0 then if mod x 5 == 0 then "fizzbuzz" else "fizz" else if mod x 5 == 0 then "buzz" else show x

altParity3 fromN toN = [(a, b, c) | a <- [fromN..toN], b <- [fromN..toN], c <- [fromN..a-1], (b /= a || b /= c), (odd a /= odd b || odd b /= odd c || odd a /= odd c)]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' f (x:xs) = f x || any' f xs

-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = if p x0 then (x0 : while p f (f x0)) else [] 
intersectI (a,b) (c,d) = ((a < c) && (b < d)) || ((a > c) && (b > d))
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = [x | x <- xs] ++ cycle' xs


-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

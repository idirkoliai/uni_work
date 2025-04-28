import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors x = [xs | xs <- [1..x-1], mod x xs == 0] 


perfects :: Int -> [Int]
perfects x = [xs | xs <- [1..x-1], sum(properFactors xs) == xs]

fizz :: Int -> String
fizz n = if mod n 3 == 0 && mod n 5 == 0 then "fizzBuzz" else if mod n 3 == 0 then "fizz"
    else if mod n 5 == 0 then "buzz" else "n"

fizzBuzz :: [String]
fizzBuzz = [fizz x | x <- [1..10]]
        

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN],y <- [fromN..toN],z <- [fromN..x], y /= z || y /= x, x /= z,x /= fromN, z /= y || z /= x]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _[] = False
any' p xs = if p (head xs) then True else any' p (tail xs)

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr(\x acc -> if p x then True else False) False xs

-- group' :: Eq a => [a] -> [[a]]
group' xs = foldr(\x acc -> if x == head acc then x:acc else [x]++acc )[head xs] xs 

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0
    |p x0  = x0 : while p f (f x0) 
    | otherwise = []

-- syracuse :: Int -> [Int]

--loop :: Int -> (a -> a) -> a -> [a]
--loop k f x0 = while (<=k) f x0


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle xs


-- borders :: (Eq a) => [a] -> [[a]]

sublists :: Int -> [a] -> [[a]]
sublists 0 [] = [[]]
sublists _ [] = []
sublists k (x:xs)
    | k < 0 = []
    | otherwise = map (x:) (sublists (k-1) xs) ++ sublists k xs


-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI i1 i2 = if ()

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

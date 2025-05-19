import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], x == sum (properFactors x)]

--fizzBuzz :: [String]
--fizzBuzz xss = [xs | x <- [1..n],  `mod` 3 == 0 show ]

--altParity3 :: Int -> Int -> [(Int, Int, Int)]
--altParity3 fromN toN = [(x, y, z) | x <- [fromN..toN] && y <- [fromN..toN], z <-[fromN..toN], z < x && (x /= x || y /= z) && (even x /= even y)]

---
--- Exercice 2
---

any' :: (a -> Bool) -> [a] -> Bool
any' p _ = False
any' p (x:xs)
    | p x = True 
    | otherwise = any' p xs 

any'' :: (a -> Bool) -> [a] -> Bool
any'' = foldr (\p x acc -> if p x then True else acc) False

group' :: Eq a => [a] -> [[a]]
group' xs = go xs [] 
    where 
        go [] acc = acc
        go [x] acc = acc ++ x 
        go (x:y:xs) acc 
            | x == y = go xs (x:y:acc)
  
while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f k = go p f x0 acc 
    where 
        go p f 


syracuse :: Int -> [Int]
syracuse k = go k []
    where 
        go 0 acc = acc 
        go k acc 
            | while even k (k `div` 2) k 
            | while odd k ((k `mul` 3) + 1) k
            | otherwise go (k-1) acc

loop :: Int -> (a -> a) -> a -> [a], Int

 Exercice 3

cycle' :: [a] -> [a]
cycle' [] = []
cycle' (x:xs) = x ++ cycle' xs

borders :: (Eq a) => [a] -> [[a]]
borders [] = []
-- borders x = [[], x]
borders (x:xs) 
    | init xs == x = x : borders xs 
    | otherwise = borders xs 

sublists :: Int -> [a] -> [[a]]
sublists _ [] = []
--sublists 0 _ = []
sublists k xs = take k (xs) : sublists k (drop (k-1) xs)

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

unitI :: [(Int, Int)] -> Bool
unitI is 

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

import           Data.List


--
-- Exercice 1
--


properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..(n-1)], n `mod` x == 0 ]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..(n-1)], x == sum(properFactors x)]

--fizzBuzz :: [String]


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | z <- [fromN..toN], y <-[fromN..toN],x <- [fromN..toN], z < x && (y/= x || y/=z) && go x y z]
    where 
        go x y z
            | even x && even y && even z = False 
            | odd x && odd y && odd z = False
            | otherwise = True

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x :xs) 
    | p x = True
    | otherwise = any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' f = foldr(\x acc -> if f x then True else acc) False

--group' :: Eq a => [a] -> [[a]]
--group'  = foldr (\x acc -> if x /= x == head acc then x : acc else [x] ) [[]] 

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x
    | not(p x) = []
    | otherwise = x : while p f (f x) 

syracuse :: Int -> [Int]
syracuse x = res ++ [1]
    where 
        res = while ( > 1) (\x -> if even x then x `div` 2 else (x * 3) + 1) x


-- loop :: Int -> (a -> a) -> a -> [a], Int


--
-- Exercice 3
--

-- cycle' :: [a] -> [a]


-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI i1 i2 = (snd i1 >= fst i2 && snd i1 <= snd i2) || (fst i1 >= fst i2 && fst i1 <= snd i2)  

unitI :: [(Int, Int)] -> Bool
unitI [] = True

    

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

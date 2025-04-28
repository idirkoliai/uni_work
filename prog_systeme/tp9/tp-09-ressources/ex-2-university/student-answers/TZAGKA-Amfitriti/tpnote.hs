import Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]

-- perfects :: Int -> [Int]

-- fizzBuzz :: [String]

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]




properFactors :: Int -> [Int]
properFactors k = [x | x<-xs, k `mod` x == 0]
    where 
        xs = [1..k-1]




perfects :: Int -> [Int]
perfects k = [x | x<-xs, sum (properFactors x) == x ]
    where 
        xs = [1..k]





sameParity :: Int -> Int -> Int -> Bool
sameParity  x y z = if ((even x == True && even y == True) && even z == True) || ((odd x == True && odd y == True) && odd z == True)   then True else False


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN], y <- [fromN..toN], z<- [fromN..toN], z < x, (y /= x || y /=z), (sameParity x y z) == False]










--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool

-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


any' :: (a -> Bool) -> [a] -> Bool
any' f (x:xs)
    | (f x == True) = True
    | (f x == False) = False
    | otherwise = any' f xs


any'' :: (a -> Bool) -> [a] -> Bool
any'' f xs = foldr (\x acc -> if f x then True else False) False xs



--group' :: (Eq a) => [a] -> [[a]]
--group' xs = [foldr (\x acc -> if x == acc then x:[] else acc)xs []]
















--
-- Exercice 3
--

-- cycle' :: [a] -> [a]

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]



cycle' :: [a] -> [a]
cycle' xs = concat (repeat xs )






sublists :: Int -> [a] -> [[a]]
sublists k [] = [[]]
sublists 0 xs = [[]]
sublists k (x:xs) = map (x:) ([take (k-1) xs]) ++ sublists xs




--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

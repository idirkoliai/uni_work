import           Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]
properFactors x = [x' | x' <- [1..(x-1)], x `mod` x' == 0]

-- perfects :: Int -> [Int]
perfects x = [x' | x' <- [1..x], x' == sum (properFactors x')]

-- fizzBuzz :: [String]
fizzBuzz = [ x | x <- [1..], x `mod` 3 == 0 || x `mod` 5 == 0]

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 x' y' = [(x,y,z) | x <- [x'..y'], y <- [x'..y'], z <- [x'..y'], z < x, y /= x || y/= z, notParity x y z]
    where
        notParity x y z 
            | even x && even y && even z = False
            | odd x && odd y && odd z    = False
            | otherwise                  = True

--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool
any' p (x : xs) 
    | p x        = True
    | not (p x)    = False
    | otherwise  = any' p xs

-- any'' :: (a -> Bool) -> [a] -> Bool
any'' p (x : xs) = foldr (\x acc -> (p x == True) || acc) False []

-- group' :: Eq a => [a] -> [[a]]
group' (x : y : xs) = [foldr (\x acc -> (x==y) : acc) []]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = [f x | x <- [x0..1000-1], p x]

-- syracuse :: Int -> [Int]

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

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

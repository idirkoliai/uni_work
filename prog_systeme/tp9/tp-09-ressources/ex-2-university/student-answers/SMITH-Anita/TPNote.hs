import           Data.List

--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x| x<-[1..n-1], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x| x<-[1..n], sum (properFactors x) == x]

fizzBuzz :: [String]
fizzBuzz = [show x| x<-[1..], mod x 3 == 0]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z)| x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x, y /= x || y /= z, (even x && even y && even z) == False, (odd x && odd y && odd z) == False]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs) = if p x then True else any' p xs  

any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr (\x acc -> if p x then True else acc) False

--group' :: Eq a => [a] -> [[a]]

--while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while p f x0 = x0 : dropWhile p 

-- syracuse :: Int -> [Int]


-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = [x| x<- xs] ++ cycle' xs

--borders :: (Eq a) => [a] -> [[a]]
--borders "" = [""]

sublists :: Int -> [a] -> [[a]]
sublists 0 _ = [[]]
sublists _ [a] = [[a]]
sublists k (x:xs) = let rest = sublists k xs in rest ++ map (x:) rest

--select :: [a] -> [(a, [a])]
--select [] = []
--select [a] = [(a,[])]
--select (x:xs) = (n, xs')
--    where
--        n = x : select xs
--        xs' = drop x xs

--partitions :: [a] -> [[[a]]]
--partitions [] = [[[]]]
--partitions (x:xs) = let rest = partitions xs in rest ++ map (x:) rest


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI i1 i2 = if (fst i1 > fst i2) && (snd i2 > fst i1) || (fst i1 < fst i2) && (snd i1 < snd i2) then True else False 

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

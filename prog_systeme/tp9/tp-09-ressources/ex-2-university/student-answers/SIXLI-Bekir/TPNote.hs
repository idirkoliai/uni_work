import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1 .. n-1], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n =[x | x <- [1 .. n], parfait x]
	where
		parfait y 
			|y== sum (properFactors y)	= True
			|otherwise 	= False

-- fizzBuzz :: [String]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN .. toN], y <- [fromN .. toN], z <- [fromN .. toN], z < x, (y/= x || y/=z), ((even x && even y && even z) /= True) && ((odd x && odd y && odd z) /= True)] 


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p xs =if (p (head xs)) then True else any' p (tail xs)



-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs


--borders :: (Eq a) => [a] -> [[a]]
--borders [] = [[]]
--borders


sublists :: Int -> [a] -> [[a]]
sublists 0 _ = [[]]
sublists k xs = [[y] | y <- xs, length [y] == k]


--select :: [a] -> [(a, [a])]
--select xs = [(z, [b]) | z<-xs , b<- privatea xs]
	--where
		--privatea xs= delete z xs


-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

--intersectI :: (Int, Int) -> (Int, Int) -> Bool
--intersectI i1 i2

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

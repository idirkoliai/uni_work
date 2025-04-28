import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors k = [n | n <- [1..k-1], k `mod` n == 0]


perfects :: Int -> [Int]
perfects k = [n | n <- [1..k], k == sum (properFactors n)]

-- fizzBuzz :: [String]

--fizzBuzz xs = [if x `mod` 3 == 0 then "fizz" 
--	else if x `mod` 5==0 then "buzz" 
--	else if (x `mod` 3 == 0) and  (x `mod` 5==0 ) then "fizzBuzz" 
--	else show x | x <- xs ]

--fizzBuzz xs = [x | x <- xs ,  
--	if x `mod` 3 == 0 then "fizz" 
--	else if x `mod` 5==0 then "buzz" 
--	else if (x `mod` 3 == 0) and  (x `mod` 5==0 ) then "fizzBuzz" 
--	else show x ]


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x<- [fromN..toN], y<- [fromN..toN], z<- [fromN..toN], z<x, (not (y == x) || not (y == z)), (not (even x==even y && even x==even z) || not (odd x==odd y && odd x==odd z) ) ]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs) = if p x then True else any' p xs

-- any'' :: (a -> Bool) -> [a] -> Bool

--group' :: Eq a => [a] -> [[a]]
--group' = foldr(\x acc acc1 -> if x== head acc1 then  x: acc1 else acc ++ acc1) [] 


--while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while p f x = map p (map f v) 




--syracuse :: Int -> [Int]
--syracuse 1 = [1]
--syracuse x = if even x==True then syracuse x `div` 2 else syracuse succ ( x `mult` 3 )



--loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = [x | _ <- [1..], x <- xs]


--borders :: (Eq a) => [a] -> [[a]]
--borders [] = [[]]
--borders (xs:xss) = xs ++ borders xss




--sublists :: Int -> [a] -> [[a]]
--sublists 0 _ = [[]]
--sublists x (y:ys) = map y ((sublists (x-1) ys )



select :: [a] -> [(a, [a])]
select [] = []
select (x:xs) = zip x (tail xs)

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

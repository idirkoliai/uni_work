import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors x =  [n |n <- [1..(x-1)], mod x n == 0]

perfects :: Int -> [Int]
perfects x = [n | n <- [1 ..x] , sum (properFactors n) == n]

fizzBuzz :: [String]
fizzBuzz = [ if  (n `mod` 3 == 0 && n `mod` 5 == 0) then "FizzBuzz" else if n `mod` 5 == 0 then "Buzz" else if n `mod` 3 == 0 then "fizz" else show n  | n <- [1..] ]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 nMin nMax  = [ (x,y,z) |x <-[nMin..nMax],y <-[nMin..nMax],z <-[nMin..nMax],z < x ,y /= x || y /= z, even x && even y && even z /= True ]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = True
any' p (x:xs) = p x || any' p xs


--any'' :: (a -> Bool) -> [a] -> Bool
--any'' f acc 


-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

-- cycle' :: [a] -> [a]

-- borders :: (Eq a) => [a] -> [[a]]

--sublists :: Int -> [a] -> [[a]]
--sublists 0 _ = [[]]
--sublists a (x:xs) =  sublists 




-- select :: [a] -> [(a, [a])]

partitions :: [a] -> [[a]]
partitions [] = [[]]
partitions (x:xs) =  partitions xs ++ [ x : ys | ys <- partitions xs] 


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x,y) (a,b) 
    | y > a = True
    | otherwise = False


-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

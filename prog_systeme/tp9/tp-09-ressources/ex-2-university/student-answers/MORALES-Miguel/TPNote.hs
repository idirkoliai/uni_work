import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x| x<-[1..n-1], n`mod`x ==0 ]

perfects :: Int -> [Int]
perfects n =[x| x<-[1..n], x== sum (properFactors x)]


fizzBuzz :: [String]
fizzBuzz = [f x| x<-[1..]]
    where
    f 1 = "1" 
    f 2 = "2" 
    f x
        | x`mod`3 == x`mod`5  = "fizzbuzz"
        | x`mod`3 == 0 = "fizz"
        | x`mod`5 == 0 = "buzz"
        | otherwise = show x  


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [ (x,y,z)| x<-[fromN..toN],y<-[fromN..toN],z<-[fromN..toN],x>z, (y/=x || y/=z), (even z/=even y)/=even x ]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' fonct [] = False
any' fonct (x:xs)
    | (fonct x) == True = True
    | otherwise = any' fonct xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' fonct = foldr(\x acc-> if (fonct x) == True then True else acc) False

--group' :: Eq a => [a] -> [[a]]
--group' (x:xs) = foldr(\s acc-> if s == head xs then [s]:acc else acc) [] xs

--while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while predic fonct init = reverse (f predic fonct [init])
--    where
--    f predic fonct  lst
--        | predic (fonct (head lst)) = fonct (head lst) : f predic fonct lst 
--        | otherwise = [] 

--app :: Int -> Int
--app n 
--    |even n = n `div` 2
--    |otherwise = ((*) n 3) + 1

--syracuse :: Int -> [Int]
--syracuse init = while (\x -> >1) app


--loop :: Int -> (a -> a) -> a -> [a]
--loop k fonct init = foldr(\x acc-> if k/= length acc then acc++[fonct (last acc)] else []) [init] [init]

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' []=[]
cycle' lst= lst++cycle' lst


-- borders :: (Eq a) => [a] -> [[a]]

--sublists :: Int -> [a] -> [[a]]



-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

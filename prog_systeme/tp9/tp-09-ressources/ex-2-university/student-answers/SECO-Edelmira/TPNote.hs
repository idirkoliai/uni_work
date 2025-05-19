import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], n `mod` x == 0] 

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (properFactors x) == x]


--fizzBuzz :: [String]
--fizzBuzz p = p : fizzBuzz

--altParity3 :: Int -> Int -> [(Int, Int, Int)]
--altParity3 a b = ([x | x <- [a..b], x ][][])


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:y) = p x || any' p y

any'' :: (a -> Bool) -> [a] -> Bool
any'' f x  = let y = map(f) x in foldr (||) False y

group' :: Eq a => [a] -> [[a]]
group' [] = []
group' [x] = [[x]]


while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = if p x0 then x0 : while p f (f x0) else [] 


syracuse :: Int -> [Int]
syracuse 1 = [1]
syracuse n  = if even n then
                n : syracuse (n `div` 2) 
            else 
                n : syracuse ((n * 3) + 1)
   

loop :: Int -> (a -> a) -> a -> [a]
loop k f x0 = take k $ iterate f x0





--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' a = a ++ cycle' a

borders :: (Eq a) => [a] -> [[a]]
borders [] = [[]]
borders [x] = [[x]]  




--sublists :: Int -> [a] -> [[a]]
--sublists 0 [] = [[]]
 

select :: [a] -> [(a, [a])]
select [] = []
select (x:y) = (x, y) : select (y)


partitions :: [a] -> [[[a]]]
partitions [] = [[]]
partitions [x] = [[[x]]]
--partitions x = partitions [tail x] ++ [[[x]]] 

--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (a,b) (x,y) = (a < y && b > x)

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [(a, b)] = True
unitI [(a,b), (x,y)] = (a-x == b-y)



isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [(a, b)] = True
isLeftSortedI [(a,b), (x,y)] = (a < x && b < y)

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (a,b) (x,y) = (min a x, max b y)

coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [(a, b)] = [(a, b)]
coversLeftSortedI [(a,b), (x,y)] = [(a,b), (x,y)]


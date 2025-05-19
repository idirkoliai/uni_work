import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors 0 = []
properFactors n = [x | x <- [1..n], (n `mod` x) == 0 && n /= x]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (properFactors x) == x]

fizzBuzz :: [String]
fizzBuzz = [show x | x <- [1..]]
--  where 
--    go x = if x `mod` 3 == 0 then "fizz" else "buzz"
-- si mod 5 alors buzz 


--altParity3 :: Int -> Int -> [(Int, Int, Int)]
--altParity3 fromN toN = [ ]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False 
any' p (x:xs) = if p x then True else any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr (\x acc -> if p x then True else acc) False xs

group' :: Eq a => [a] -> [[a]]
group' [] = []
group' [x] = [[x]]
group' (x:y:xs) = if x == y then [x] : group' (y:xs) else [[x]] ++ group' (y:xs)

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = if p x0 then x0 : while p f (f x0) else []

--syracuse :: Int -> [Int]
--syracuse n = while (/= 1) (if even n then n : syracuse (n `div` 2) else n : syracuse (n * 3 + 1)) n

loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop k f x0 = x0 : loop (pred k) f (f x0)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = go xs 
  where 
    go [] = go xs 
    go (y:ys) = y : go ys

borders :: (Eq a) => [a] -> [[a]]
borders [] = [[]]
borders [x] = [[],[x]]

sublists :: Int -> [a] -> [[a]]
sublists 0 xs = [[]]
--sublists k (x:xs) = 

select :: [a] -> [(a, [a])]
select [] = []
select [x] = [(x, [])]
--select (x:xs) = x : select xs 

partitions :: [a] -> [[[a]]]
partitions [] = [[]]
partitions [x] = [[[x]]]


--
-- Exercice 4
--

--intersectI :: (Int, Int) -> (Int, Int) -> Bool
--intersectI i1 i2 = let ((x,y),(w,z)) = if y < w then True else False in 

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [x] = True
--unitI (x:y:is) = if sum x == sum y then unitI else 

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]


-- perfects :: Int -> [Int]

-- fizzBuzz :: [String]

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]


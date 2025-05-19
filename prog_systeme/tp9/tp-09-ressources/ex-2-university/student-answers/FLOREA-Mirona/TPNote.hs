import Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors 0 = []
properFactors n = [i | i <- [1..n-1], (n `mod` i) == 0]


perfects :: Int -> [Int]
perfects 0 = []
perfects n = [i | i <- [1..n], (sum $ properFactors i) == i]

--fizzBuzz :: [String]
--fizzBuzz = map (\x -> whatIs x) [1..]
-- where
-- 	whatIs x
-- 	 | (x `mod` 3) == 0 && (x `mod` 5) == 0 = "fizzbuzz"
-- 	 | x `mod` 3 = "fizz"
-- 	 | x `mod` 5 = "buzz"
-- 	 | otherwise = "x"

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' f (x : xs) = if f x then True else any' f xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' f xs = foldr (\s acc -> if f s then True else acc) False xs

group' :: Eq a => [a] -> [[a]]
group' xs = foldr (\s acc -> if s == (head acc) then s : acc else inits xs) [[]] []

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0
 | not (p x0) = []
 | otherwise = x0 : while p f (f x0)

syracuse :: Int -> [Int]
syracuse n = while (\x -> not (x == 1)) (\y -> if even y then y `div` 2 else y * 3 + 1) n

loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop n f x0 = x0 : loop (pred n) f (f x0) 
	


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = []
cycle' lst@(x : xs) = (++) lst (cycle' lst)

borders :: (Eq a) => [a] -> [[a]]
borders [] = []
borders [x] = [[], [x]]
borders lst@(x : xs) = [take i lst | i <- [1..length lst], (take i lst) `isSuffixOf` lst && ((take i lst) `isPrefixOf` lst)]

sublists :: Int -> [a] -> [[a]]
sublists _ [] = [[]]
sublists 0 _ = [[]]
sublists n lst@(x : xs)
 | n > (length lst) = [[]]
 | otherwise = [acc | acc <- sublists (pred n) xs]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (u1, u2) (y1, y2) = if (u1 < y2) && (u2 > y1) then True else False

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [_] = True
unitI (x1@(u1, u2) : x2@(y1, y2) : xs) = let diff = (u2 - u1) in diff == (y2 - y1) && unitI xs

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [_] = True
isLeftSortedI (x1@(u1, _) : x2@(y1, _) : xs) = (u1 <= y1) && isLeftSortedI (x2 : xs)

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI i1@(u1, u2) i2@(y1, y2)
 | (abs $ y2 - u1) > (abs $ u2 - y1) = if y2 > u1 then (u1, y2) else (y2, u1)
 | otherwise = if u2 > y1 then (y1, u2) else (u2, y1)

coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [] = []
coversLeftSortedI [x] = [x]
coversLeftSortedI lst@(x : xs) = [coverI i1 i2 | i1 <- lst, i2 <- lst]
 --where
 --	withoutDup [] = []
 --	withoutDup (x : xs) = if elem x xs then delete x xs else withoutDup

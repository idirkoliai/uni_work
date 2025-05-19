import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], n `mod` x == 0]

-- perfects :: Int -> [Int]

--fizzBuzz :: [String]
--fizzBuzz = [x | x <- [1..], if x `mod` 3 == 0 && x `mod` 5 == 0 then show fizzBuzz else (if x `mod` 3 == 0 then show fizz else( if x `mod` 5 == 0 then show buzz else (show x)))]

--altParity3 :: Int -> Int -> [(Int, Int, Int)]
--altParity3 fromN toN = [(x,y,z) | x,y,z <- [fromN..toN] , (z < x) && (y /= x || y /= z) && (not(even x && even y && even z) || not(odd x && odd y && odd z))]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs)
  | p x = True
  | otherwise = any' p xs


any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr (\x acc -> if p x then True else acc) False

--group' :: Eq a => [a] -> [[a]]
--group' xs = foldr (\x acc -> if ) []

--while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while p f x0
--  | f x0 : while p f x0
--  | otherwise = p f x0
 

--syracuse :: Int -> [Int]
--syracuse n = let number = n (if (even number) then number`mod`2 else(number*3 +1))
--  in while (/=1) syracuse number

loop :: Int -> (a -> a) -> a -> [a]
loop 0 f x0 = []
loop k f x0 = x0: loop (pred k) f (f x0)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = []
cycle' xs = xs ++ cycle' xs

borders :: (Eq a) => [a] -> [[a]]
borders [] = [[]]
borders [a] = [[], [a]]

sublists :: Int -> [a] -> [[a]]
sublists 0 _ = [[]]
sublists k xs = map (take k) $ permutations xs 


select :: [a] -> [(a, [a])]
select [] = []
select [a] = [(a, [])]
select (x:xs) = (x, xs) : select xs

partitions :: [a] -> [[[a]]]
partitions [] = [[]]
partitions [a] = [[[a]]]
partitions xs = [subsequences xs]
--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

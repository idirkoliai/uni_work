import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], mod n x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (properFactors x) == x]

fizzBuzz :: [String]
fizzBuzz = [if mod x 3 == 0 then if mod x 5 == 0 then "fizzbuzz" else "fizz" else  if mod x 5 == 0 then "buzz" else show x | x <- [1..]]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN.. toN], y <- [fromN.. toN], z <- [fromN.. toN], z<x, y /= x || y /= z, (even x && even y && even z) == False, (odd x && odd y && odd z) == False]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' f (x : xs)
  | f x = True
  | otherwise = any' f xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' f = foldr(\x acc -> (f x) || acc) False

--group' :: Eq a => [a] -> [[a]]
--group' xs = foldr(\x acc -> if elem x (head acc) then [x] : acc else [x] : acc) xs

while ::(a -> Bool) -> (a -> a) -> a -> [a]
while p f n = takeWhile(p) (n: while p f (f n))

syracuse :: Int -> [Int]
syracuse n = while (/=1) f n ++ [1]
  where
    f m
	  | odd m = m * 3 + 1
      | otherwise = div m 2 

loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop k f x = x : loop (k-1) f (f x)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' x = x ++ cycle' x

-- borders :: (Eq a) => [a] -> [[a]]
-- borders [] = [""]
-- borders   xs

sublists :: Int -> [a] -> [[a]]
sublists k xs = filter (\y -> length y == k) (subseq xs)
	where
		subseq [] = [[]]
		subseq (y:ys) = [y : s | s <- subseq ys] ++ subseq ys

-- select :: [a] -> [(a, [a])]
-- select x = [(z, y) | z <- x, y <- reverse (sublists (length x - 1) x), not (z `elem` x)]
-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI x y
	| b < d && c > b = True
	| b > d && c < b = True
	| otherwise = False
	where
		(a,b) = x
		(c,d) = y

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [x] = True
unitI (x : y : xs)
	| f x == f y = unitI (y : xs)
	| otherwise = False
	where
		f (a, b) = b -a

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

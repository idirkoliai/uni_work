import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors k = [word | word <- k, k `mod` 2 == 0]

perfects :: Int -> [Int]
perfects k = [word | word <- k, sum(properFactors k) == k]

fizzBuzz :: [String]
fizzBuzz k
	| 0 = []
	| k `mod` 3 == 0 && k `mod` 5 == 0 = "fizzbuzz" : fizzBuzz k-1
	| k `mod` 3 == 0 = "fizz" : fizzBuzz k-1
	| k `mod` 5 == 0 = "buzz" : fizzBuzz k-1
	| otherwise = k : fizzBuzz k-1

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,x',x'') | x <- [fromN..toN],x' <- [fromN..toN],x'' <- [fromN..toN], fromN <= x <= toN && fromN <= x' <= toN && fromN <= x'' <= toN && z < x && ( y/=x || y /= z) &&
not (even x && even y && even z)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _[] = False
any' p (x:xs)
	| p x = True
	| otherwise = any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr(\x acc -> p x || acc)False

group' :: Eq a => [a] -> [[a]]
group' = foldr(\x acc ->(y == x) || acc) []

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = [word | word <- x0 , p(f x0)]

syracuse :: Int -> [Int]
syracuse 1 = []
syracuse k = while (== 1) (if even k then k / 2 else k*3+1) k

loop :: Int -> (a -> a) -> a -> [a], Int)
loop 0 f x0 = []
loop k f x0 = f x0 : loop k-1 f x0

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = error "La liste ne doit pas être vide"
cylce' xs = xs ++ cycle' xs

--borders :: (Eq a) => [a] -> [[a]]

sublists :: Int -> [a] -> [[a]]
sublists 0 = []



--select :: [a] -> [(a, [a])]


--partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x,y) (w,z) 
	| x < w && y > z && x < w = True
	| x < w && y < z && x < w = True
	| x > w && y > w = True
	| otherwise = False

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI x = True
unitI x:y:xs 
	| sum(x) == sum(x) = unitI y:xs
	| otherwise = False

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [(x,y),(z,w)] xs
	| x < z = isLeftSortedI xs
	| otherwise = False

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (x,y) (z,w)
	| x < z && y < w && x < w && y < z = (x,w)
	| x > z && x < w && y > z = (z,y)
	| x > z && x > w && y > z = (z,y)
	| otherwise = (y,z)

coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

import           Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]

-- perfects :: Int -> [Int]

-- fizzBuzz :: [String]

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]


--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool

-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

-- cycle' :: [a] -> [a]

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]


properFactors :: Int -> [Int]
properFactors n  = [x | x <- [1..(n-1)], (mod n x) == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..(n-1)], (sum (properFactors x)) == x]

fizzBuzz :: [String]
fizzBuzz = [if ((mod x 5) == 0) && ((mod x 3) == 0) then "fizzbuzz" else if (mod x 5) == 0 then "buzz" else if (mod x 3) == 0 then "fizz" else show x | x <- [1..]]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [ (x,y,z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x, y /= x || y /= z, ((mod y 2 /= mod x 2) || (mod z 2 /= mod x 2) || (mod z 2 /= mod y 2))]



any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f (x : xs) 
  | f x = True
  | otherwise = any' f xs

cycle' :: [a] -> [a]
cycle' xs = concat (repeat xs)

borders :: (Eq a) => [a] -> [[a]]
borders [] = [[]]
borders [x] = [[],[x]]
borders (x : xs) 
  | x == (last xs) = [x] : borders xs
  | otherwise = borders xs



intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x,y) (w,z)
  | w > y || x > z = False
  | otherwise = True 

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [x] = True
unitI ((x,y) : (w,z) :xs) = if (y-x) == (z-w) then unitI xs else False

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [x] = True
isLeftSortedI [(x,y),(w,z)] = if (x <= w) then True else False
isLeftSortedI ((x,y) : (w,z) : xs) = if (x <= w) && (let (j,p) = head xs in j >= w) then isLeftSortedI xs else False


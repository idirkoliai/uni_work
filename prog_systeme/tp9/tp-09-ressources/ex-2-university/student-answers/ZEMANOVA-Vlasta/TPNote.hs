import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [k | k <- [1..n-1], n `mod` k == 0]


perfects :: Int -> [Int]
perfects n = [k | k <- [2..n-1], sum (properFactors k) == k]

fizzBuzz :: [String]
fizzBuzz = [f i | i <- [1..]]
  where
    f i
      | i `mod` 3 == 0 && i `mod` 5 == 0 = show "fizzbuzz"
      | i `mod` 3 == 0 = show "fizz"
      | i `mod` 5 == 0 = show "buzz"
      | otherwise = show i

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN],
                         z < x, 
                         y /= x || y /= z, 
                         (x `mod` 2) /= (y `mod` 2) || (x `mod` 2) /= (z `mod` 2)]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f xs@(x : xs') = f x || any' f xs'

any'' :: (a -> Bool) -> [a] -> Bool
any'' f xs@(x : xs') = foldr (||) False  [f y | y <- xs]

group' :: Eq a => [a] -> [[a]]
group' [] = [[]]
group' xs@(x : xs') = [foldr (:) [x] [y | y <- takeWhile (x == ) xs']] ++ group' (dropWhile (x == ) xs')

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = takeWhile p (iterate f x0)

syracuse :: Int -> [Int]
syracuse n = while (\x -> x /= 1) go n ++ [1]
    where
      go n 
        | n `mod` 2 == 0 = n `div` 2
        | otherwise = (n * 3) + 1

loop :: Int -> (a -> a) -> a -> [a]
loop k f x0 = take k (while (\x -> True) f x0) 


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = []
cycle' xs@(x : xs') =  [k | k <- xs] ++ cycle' xs

-- borders :: (Eq a) => [a] -> [[a]]


-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI i1 i2 
    | fst i1 <= fst i2 && fst i2 <= snd i1 = True
    | snd i1 >= fst i2 && snd i1 <= snd i1 = True
    | otherwise = False

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

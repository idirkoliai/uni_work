import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [ m | m <- [1..n-1], mod n m == 0]

perfects :: Int -> [Int]
perfects n = [ m | m <- [1..n], sum (properFactors m) == m]

fizzBuzz :: [String]
fizzBuzz = [ f x | x <- [1..]]
  where
  f x
    | mod x 3 == 0 && mod x 5 == 0 = "fizzbuzz"
    | mod x 3 == 0 = "fizz"
    | mod x 5 == 0 = "buzz"
    | otherwise = show x

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [ (x, y, z) | z <- [fromN..toN], x <- [fromN..toN], y <- [fromN..toN],
                          z < x,
                          x /= y || y /=z,
                          not (even x == even y && even x == even z)
                        ]
                          

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x : xs) = p x || any' p xs 

any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr (\ x flag -> flag  || p x) False

group' :: Eq a => [a] -> [[a]]
group' = foldr f []
  where
    f x [] = [[x]]
    f x acc'@(xs : acc)
      | elem x xs = (x : xs) : acc
      | otherwise = [x] : acc'
      
while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = takeWhile p $ iterate f x0


syracuse :: Int -> [Int]
syracuse n = while (/= 1) f n ++ [1] 
  where
    f x
      | even x = div x 2
      | otherwise = 3*x + 1 

loop :: Int -> (a -> a) -> a -> [a]
loop k f x0 = take k $ iterate f x0
--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

borders :: (Eq a) => [a] -> [[a]]
borders [] = [[]]
borders xs = go [[]] 1 xs
  where
    go acc k [x] = go ([x] : acc) k []
    go acc k xs
      | k == length xs = reverse (xs : acc)
      | suffix == prefix = go (suffix : acc) (k+1) xs
      | otherwise = go acc (k+1) xs
      where
        (suffix, prefix) = (takeWhile (<= k) xs, dropWhile ( <= (length xs) - k) xs)

{-sublists :: Int -> [a] -> [[a]]
sublists = go []
  where
    go _ 0 _ = [[]]
    go _ _ [] = [[]]
    go acc _ [] = acc
    go acc k (x : xs)
-}

select :: Eq a => [a] -> [(a, [a])]
select xs = go [] xs xs
  where
    go acc [] _ = reverse acc
    go acc (x : xs) original = go ((x, delete x original) : acc) xs original 
    
   {-************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************-************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
-}
-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x, x') (y , y') = not (x' < y || y' < x)

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI ((x, x') : xs) = all (\ (y, y') -> y' - y == x' - x) xs

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [x] = True
isLeftSortedI ((x, _) : xs) = go x xs
  where
    go _ [] = True
    go x ((y, _) : ys) = (x <= y) && go y ys

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (x, x') (y, y') = (min x y, max x' y')

coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [] = []
coversLeftSortedI [i] = [i]
coversLeftSortedI (i : is@(i' : is'))
  | intersectI i' i = coversLeftSortedI ((coverI i i') : is')
  | otherwise = i : coversLeftSortedI is


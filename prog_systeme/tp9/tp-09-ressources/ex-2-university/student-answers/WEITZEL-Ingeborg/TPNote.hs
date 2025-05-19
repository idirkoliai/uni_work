import           Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]
properFactors :: Int -> [Int]
properFactors n = [a | a <- [1..n-1], mod n a == 0]

-- perfects :: Int -> [Int]
perfects :: Int -> [Int]
perfects n = [a | a <- [1..n], a == sum (properFactors a)]

-- fizzBuzz :: [String]
fbShow :: Int -> String
fbShow x
    | mod x 15 == 0 = "fizzbuzz"
    | mod x 3 == 0 = "fizz"
    | mod x 5 == 0 = "buzz"
    | otherwise = show x

fizzBuzz :: [String]
fizzBuzz = [ fbShow a | a <- [1..]]

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 f t = [(x, y, z) | x <- [f..t], y <- [f..t], z <- [f..t], z < x, (y /= x) || (y  /= z), (length (filter odd [x, y, z]) == 1) || (length (filter odd [x, y, z]) == 2)]

--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' f (x : xs) = if f x then True else any' f xs

-- any'' :: (a -> Bool) -> [a] -> Bool
any'' f = foldr(\x acc -> acc || (f x)) False

-- group' :: Eq a => [a] -> [[a]]
group' :: (Eq a) => [a] -> [[a]]
group' [] = []
group' (y : ys) = foldr(\a acc@(x : xs) -> if a == head x then (a : x) : xs else [a] : acc) [[y]] ys

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]
while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = takeWhile p (iterate f x0)

-- syracuse :: Int -> [Int]
syracuse 1 = [1]
syracuse x = x : (if ((mod x 2) == 0) then syracuse (div x 2) else syracuse (x * 3 + 1))

-- loop :: Int -> (a -> a) -> a -> [a]
loop n f v0 = take n (iterate f v0)

--
-- Exercice 3
--

-- cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

-- borders :: (Eq a) => [a] -> [[a]]
borders xs = let l = length xs in [] : [ take i xs | i <- [1..l], drop (l-i) xs == take i xs]

-- sublists :: Int -> [a] -> [[a]]
sublists :: Int -> [a] -> [[a]]
sublists 0 _ = [[]]
sublists _ [] = [[]]
sublists k xs = [ a : b | a <- xs, b <- (sublists (k - 1) xs) ]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (a1, a2) (b1, b2) = if (a2 < b1) || (a1 > b2) then False else True

isConst :: [Int] -> Bool
isConst [] = True
isConst [_] = True
isConst (a : b : xs) = a == b && isConst (b : xs)

-- unitI :: [(Int, Int)] -> Bool
-- unitI :: [(Int, Int)] -> Bool
unitI xs = isConst (map (\(a, b) -> b - a) xs)

isLower :: [Int] -> Bool
isLower [] = True
isLower [_] = True
-- TODO: fix infinitive loop
isLower (a : b : xs) = (a <= b) && isLower (b : xs)

-- isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI xs = isLower (map (fst) xs)

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (a1, a2) (b1, b2) = (min a1 b1, max a2 b2)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [] = []
coversLeftSortedI [a] = [a]
coversLeftSortedI (a : b : xs) = if intersectI a b
    then coversLeftSortedI ((coverI a b) : xs)
    else a : coversLeftSortedI (b : xs)

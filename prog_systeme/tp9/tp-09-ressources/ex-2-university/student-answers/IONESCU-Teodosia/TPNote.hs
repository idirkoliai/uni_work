import           Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]
properFactors :: Int -> [Int]
properFactors x = [y | y <- [1..x - 1], mod x y == 0]



-- perfects :: Int -> [Int]
perfects :: Int -> [Int]
perfects x = [y | y <- [1..x-1], y == sum (properFactors y)]

-- fizzBuzz :: [String]
--fizzBuzz :: [String]
--fizzBuzz = [ show y | y <- [1..] ,if y `mod` 3 then "fizz" ]

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN], y <- [fromN..toN],z <- [fromN..toN], z < x, y /= x || y /= z, odd (x + y) || odd (y + z) || odd (x + z)]

--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool
any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' f (x:xs) = (f x )  || any' f xs

-- any'' :: (a -> Bool) -> [a] -> Bool
any'' :: (a -> Bool) -> [a] -> Bool
any'' f = foldr(\x acc -> if f x then True else acc) False
-- group' :: Eq a => [a] -> [[a]]
group' :: Eq a => [a] -> [[a]]
group' = foldr(\x acc -> if elem x (head acc) then x ++ head(acc) else acc) []

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]
while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = foldr(\x acc -> if p x then x : acc else []) [] (iterate f x0)

-- syracuse :: Int -> [Int]
syracuse :: Int -> [Int]
syracuse x = (while (/= 1) (\x -> if odd x then x*3 + 1 else x `div` 2) x )++ [1]

-- loop :: Int -> (a -> a) -> a -> [a], Int)
loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop k f x0 = take k (iterate f x0)


--
-- Exercice 3
--

-- cycle' :: [a] -> [a]
cycle' :: [a] -> [a]
cycle' x = x ++ cycle' x

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]
sublists1 :: [a] -> [[a]]
sublists1 [] = [[]]
sublists1 (x:xs) = xss ++ [x:xs | xs <- xss]
    where
        xss = sublists1 xs


sublists ::  Int -> [a] -> [[a]]
sublists _ [] = [[]]
sublists k xs = filter (\x -> length x  == k) (sublists1 xs)

-- select :: [a] -> [(a, [a])]
--select :: [a] -> [(a, [a])]



-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (a,b) (c,d) = if (a < c && b >c ) || (c < a && d > a) then True else False

-- unitI :: [(Int, Int)] -> Bool



-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
cover (a,b) (c,d) = zip (if a < b then a) (if c < d then d)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

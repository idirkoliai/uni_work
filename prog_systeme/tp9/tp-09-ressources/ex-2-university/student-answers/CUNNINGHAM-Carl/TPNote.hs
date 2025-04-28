import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors a = [x | x <- [1..(a-1)], a `mod` x == 0]

perfects :: Int -> [Int]
perfects a = [x | x <- [1..a], (sum(properFactors x)) == x]

fizzBuzz :: [String]
fizzBuzz = [ if x `mod` 3 == 0 && x `mod` 5 == 0 then "fizzbuzz" 
            else if x `mod` 3 == 0 then "fizz"
            else if x `mod` 5 == 0 then "buzz"
            else (show x)| x <- [1..]]

--altParity3 :: Int -> Int -> [(Int, Int, Int)]
--altParity3 a b = [ (x, y, z) | f <- [a..b], t <- [a..b], ]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _[] = False
any' f (x :xs) = if f x then True else any' f xs 

any'' :: (a -> Bool) -> [a] -> Bool
any'' f = foldr(\x acc -> if f x then True else acc) False

-- group' :: Eq a => [a] -> [[a]]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f a = takeWhile p (iterate f a)

syracuse :: Int -> [Int]
syracuse a = while ( > 1) (\x -> if x `mod` 2 == 0 then x `div` 2 
                                  else (x*3)+1) a ++ [1]

-- loop :: Int -> (a -> a) -> a -> [a]
-- loop a f b = while (\xs -> length xs < a) f b

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = concat(repeat xs)

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (a1,b1) (a2,b2) = if a1>a2 && a1<b2 
                             || b1>a2 && b1<b2
                             || a2>a1 && a2<b1
                             || b2>a1 && b2<b1
                             then True else False


aux' :: Int -> [(Int, Int)] -> Bool
aux' a [] = True
aux' a (x :xs) = if ((snd x) - (fst x)) == a then (aux' a xs) else False

unitI :: [(Int, Int)] -> Bool
unitI xs = aux' ((snd (head xs)) - (fst(head xs))) xs


-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

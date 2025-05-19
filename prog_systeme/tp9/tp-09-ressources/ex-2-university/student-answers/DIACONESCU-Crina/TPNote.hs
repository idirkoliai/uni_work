import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors i = [ x | x <- [1..(i-1)], (mod i x) == 0]

perfects :: Int -> [Int]
perfects i = [ x | x <- [1..i], sum (properFactors x) == x]

fizzBuzz :: [String]
fizzBuzz = [if (mod x 3) == 0 && (mod x 5) == 0 then "fizzbuzz" else (if (mod x 5) == 0 then "buzz" else (if (mod x 3) == 0 then "fizz" else show x)) | x <- [1..]]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 i j = [(x,y,z) | x <- [i..j], y <- [i..j], z <- [i..j], z < x, y /= x || y /= z, (any odd [x,y,z]) && (any even [x,y,z])]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f (x:xs) = f x || any' f xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' f = foldr (\x acc -> f x || acc) False

group' :: Eq a => [a] -> [[a]]
group' = foldr (\x acc -> if [x] == head acc then (x : (head acc)) : tail acc else [x]: acc) [[]]

--while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while p f i = takeWhile p (go f i)
--	where
--		go f i = f i : [go f i]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

borders :: (Eq a) => [a] -> [[a]]
borders [] = [[]]
borders (x:xs) = let (init, rest) = break (==x) xs in init : borders rest

sublists :: Int -> [a] -> [[a]]
sublists 0 [_] = [[]]
sublists _  [] = [[]]
sublists i (x:xs) = [x] : sublists (i-1) xs 

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (i1, j1) (i2, j2) = (if i2 <= j1 then True else False) && (if j2 <= i1 then False else True)  

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI xs = let (a, b) = (xs !! 0) in all (==(b-a)) (map (\(x, y)-> y - x) xs)

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

RABEHARINIRINA Michas Nandrianina
import           Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], n `mod` x == 0]

-- perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], x == lsum x]
 where lsum x = sum (properFactors x)


-- fizzBuzz :: [String]
fizzBuzz = [f x | x <- [1..]]
 where f x = if (x `mod` 5 == 0) && (x `mod` 3 == 0) then "fizzbuzz" else if (x `mod` 3 == 0) then "fizz" else if (x `mod` 5 == 0) then "buzz" else show x


-- altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 n k = [(x, y ,z)| x <- [n..k], y <- [n..k], z <- [n..k], z < x, (y /= x) || (y /= z) == True, even(x) && even (y) && even(z) == False]

--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs) = p x || any' p xs
-- any'' :: (a -> Bool) -> [a] -> Bool

any'' p list = foldr (\x acc -> p x ) False list

-- group' :: Eq a => [a] -> [[a]]
--group' (x:y:xs) = foldr (\x (a:b) -> if (x == a) then (a:x:y:xs) else (a:b) [[]] x:y:xs)
-- while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = x0 : [f x| x <- [x0..], p x]
--while p f x0 = takeWhile p f [x0..]
-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

-- cycle' :: [a] -> [a]
cycle' [a] = repeat a
cycle' (x:xs) = x: cycle' xs
-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]
select list = [(x,l)| x <- list]
 where l = drop x list
-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

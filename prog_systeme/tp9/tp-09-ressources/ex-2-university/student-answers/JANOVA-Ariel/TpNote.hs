import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n - 1] , n `mod` x  == 0]


divisors :: Int -> [Int]
divisors n = [x | x <- [1..n]  , n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n] , sum (divisors x) == x]




fizzBuzz :: [String]

fizzBuzz = [show x | x <-[1..] , not (x `mod` 3 == 0)]



altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x , y , z) | x <- [fromN..toN] , y <- [fromN..toN] , z <- [fromN..toN] ,z < x , y \= x || y \= z]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool

any' p xs = length (filter (\x -> p x) xs) > 0



-- any'' :: (a -> Bool) -> [a] -> Bool

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr (\x acc -> p x || acc ) False xs




group' :: Eq a => [a] -> [[a]]
group' [] = [[]]
group' [x] = [[x]]
group' xs'@(x:xs) = takeWhile (== x) xs' : group' (dropWhile (== x) xs )

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = takeWhile p (iterate f x0 )




syracuse :: Int -> [Int]
syracuse n = while ( > 1) (\x -> if x `mod` 2 == 0 then x / 2 else x * 3 + 1) n




-- loop :: Int -> (a -> a) -> a -> [a], Int)

loop :: Int -> (a -> a) -> a -> [a]
loop k f x0 = take k (iterate f x0)



--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs


borders :: (Eq a) => [a] -> [[a]]



sublists :: Int -> [a] -> [[a]]
sublists 0 _ = [[]]
sublists _ [] = [[]]
sublists n xs = take n xs : sublists n (drop n xs)




select :: [a] -> [(a, [a])]
select [] = []
select [x] = [(x, [])]
select (x:xs) = (x , xs) : select xs


-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--
intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x , y) (z , w) = x > w || y < z



unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI (x:xs) = foldr(\y acc -> fst y - snd y == fst x - snd x && acc) True xs


isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [_] = True
isLeftSortedI (x:y:xs)
    | fst x > fst y  || snd y < snd x = False
    | otherwise = isLeftSortedI (y:xs) 


-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)



-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

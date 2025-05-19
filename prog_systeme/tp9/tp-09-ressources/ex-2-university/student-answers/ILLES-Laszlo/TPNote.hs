import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [ y| y <- [1..(n - 1)] , n `mod` y == 0]

renvoie_chaine :: Int -> [String]
renvoie_chaine n 
    | n `mod` 3 == 0 = ["fizz"]
    | n `mod` 5 == 0 = ["buzz"]
    | n `mod` 3 == 0 && n `mod` 5 == 0 = ["fizzbuzz"]
    | otherwise = [show n]

--perfects :: Int -> [Int]
--perfects n = [ y|y <-[1..n] , even y && ]

fizzBuzz :: [String]
fizzBuzz = [y | z <- [1..] , y <- renvoie_chaine z]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x<- [fromN..toN] , y<- [fromN..toN ],z<- [fromN..toN ] , z < x , y /= x || y /= z , not (even y && even z && even x) || not (odd y && odd z && odd x)]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' f (x:xs) = f x || any' f xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' f liste = foldr fi False liste
    where
        fi x acc = if f x then f x || acc else acc

insertion ::Eq a => a -> [[a]] -> [[a]]
insertion e (x:xs) = if e `elem` x then [[e]] ++ [x] else insertion e xs

group' :: Eq a => [a] -> [[a]]
group' liste = foldr fi [] liste
    where
        fi x acc = if (acc == []) then [x]:acc else insertion x acc

while ::(a -> Bool) -> (a -> a) -> a -> [a]
while f e n = if (f n) then [n] ++ while f e (e n) else []

-- syracuse :: Int -> [Int]

--loop :: Int -> (a -> a) -> a -> [a]


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' n = n ++ cycle n

borders :: (Eq a) => [a] -> [[a]]
borders [] = []
borders (x:xs) = init n
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

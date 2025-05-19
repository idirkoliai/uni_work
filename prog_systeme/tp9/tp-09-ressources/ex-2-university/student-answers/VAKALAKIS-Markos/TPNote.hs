import           Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]
properFactors :: Int -> [Int]
properFactors n = [ x | x<- [1..n-1], n `mod` x == 0]

-- perfects :: Int -> [Int]
perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (properFactors x) == x]
-- fizzBuzz :: [String]
fizzBuzz :: [String]
fizzBuzz = [step x | x <- [1..]]
    where 
        step x 
            | x `mod` 3 == 0  && x `mod` 5==0 = "fizzbuzz"
            | x `mod` 3 == 0 = "fizz"
            |x `mod` 5==0 = "buzz" 
            |otherwise = show x

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]





--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs) = if p x then True else any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr (\x acc -> if p x then True else acc) False 

group' :: Eq a => [a] -> [[a]]
group'  = foldr step []
    where 
        step x [] = [[x]]
        step x (y:ys) 
            | x== head y = (x:y) :ys
            |otherwise = [x] : (y:ys)


--while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = if p x0 then x0:  while p f (f x0) else [] 
    

-- syracuse :: Int -> [Int]
 



loop :: Int -> (a -> a) -> a -> [a]
loop 0 f x0 = []
loop k f x0 = x0 : loop (k-1) f (f x0)


--
-- Exercice 3
--

-- cycle' :: [a] -> [a]
cycle' :: [a] -> [a]
cycle' [] = []
cycle' (x:xs) = x: cycle' (xs ++ [x])

-- borders :: (Eq a) => [a] -> [[a]]


sublists :: Int -> [a] -> [[a]]
sublists 0 xs = []


select :: Eq a => [a] -> [(a, [a])]
select xs = (head xs, tail xs) : foldl (\acc x -> [(x, delete x xs)] ) [] xs
    

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI i1 i2 
    | fst i1 < fst i2 && snd i1 < snd i2 = False
    | fst i1 > snd i2 && snd i1 > snd i2 = False
    |otherwise = True


unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [a] = True
unitI (x:y:xs) = if length [(fst x) .. (snd x) ] == length [(fst y) .. (snd y) ] then unitI xs else False

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [a] = True
isLeftSortedI (x:y:xs) 
    | fst x <= fst y = isLeftSortedI (y:xs)
    |otherwise = False

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI xs ys = (x , y) where
        x = if fst xs <= fst ys then fst xs else fst ys 
        y = if snd xs >= snd ys then snd xs else snd ys

coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [] =  []
coversLeftSortedI [a] = [a]
coversLeftSortedI (x:y:xs) = coverI x y  : coversLeftSortedI ((coverI x y) : xs)

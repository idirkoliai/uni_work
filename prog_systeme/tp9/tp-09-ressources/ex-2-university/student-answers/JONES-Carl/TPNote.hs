import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x<- [1..(n-1)],n `mod` x == 0]

--perfects :: Int -> [Int]
--perfects n= [x | x<- properFactors n, sum x == n]


fizzBuzz :: [String]
fizzBuzz = [transformation x | x<-[1..]]
    where 
        transformation w = if w `mod` 3 == 0 then "fizz" else if w `mod` 5 == 0 then "buzz" else show w



--altParity3 :: Int -> Int -> [(Int, Int, Int)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p xs 
    |length xs == 0 = False
    |otherwise = p (head xs) || any' p (tail xs)


any'' :: (a -> Bool) -> [a] -> Bool
any'' p=foldr(\x acc -> if p x then True else False) False



--group' :: Eq a => [a] -> [[a]]
--group' xs = foldr(\x acc -> if pred x == x then x:acc else []:acc)[]



while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f xo
    |p xo == False = []
    |otherwise = xo: while p f (f xo)


--syracuse :: Int -> [Int]
--syracuse xs=while (/=1) syracusFcnt xs
--        where syracusFcnt x = if even x then x/2 else ((x*3) +1)




--loop :: Int -> (a -> a) -> a -> [a]
--loop k f xo
--   |k<1= []
--    |otherwise= xo ++ loop((k-1) f (f xo)) 

--
-- Exercice 3
--
cycle' :: [a] -> [a]
cycle' xs = concat(repeat xs)

--borders :: (Eq a) => [a] -> [[a]]
--borders xs = foldr[\x acc -> if (tails x == inits x )then x:acc else acc][]
    

sublists :: Int -> [a] -> [[a]]
sublists k xs 
    |k == 0 = [[]]
    |otherwise= [x|x<-inits xs, (length x) == k]

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

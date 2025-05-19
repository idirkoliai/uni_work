import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..(n-1)], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], (sum (properFactors x)) == x ]

fizzBuzz :: [String]
fizzBuzz = [f x | x <- [1..]]
    where
        f x 
          | x `mod` 3 == 0 && x `mod` 5 /= 0  = "fizz"
          | x `mod` 5 == 0 && x `mod` 3 /= 0   = "buzz"
          | x `mod` 3 == 0  && x `mod` 5 == 0 = "fizzbuzz"
          | otherwise = show x 


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN],  y <- [fromN..toN], z <- [fromN..toN], z < x, y/=x || y/=z, not (even x && even y && even z) && not (odd x && odd y && odd z)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs) = if p x then True else any' p xs

-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]


while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = takeWhile (p) (iterate f x0)

syracuse :: Int -> [Int]
syracuse n = while (/= 1) calcul n ++ [1]
    where   
        calcul n 
          | even n = n `div` 2
          | otherwise = n * 3 +1


loop :: Int -> (a -> a) -> a -> [a]
loop k f x0 = take k (iterate f x0)



--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle xs

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

select :: [a] -> [(a, [a])]
select [] = []
select [x] = [(x,[])]  
select (x:xs) = take (length xs) ((x,xs) : select (drop 1 xs ++ take 1 xs))

-- partitions :: [a] -> [[[a]]]



--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI i1 i2  = if length [ x| x <- [(fst i1)..(snd i1)], x `elem` [(fst i2)..(snd i2)]] == 0 then False else True

diff :: [Int] -> [Int]
diff [] = []
diff(x:y:xs) = x-y : diff (y:xs)

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [i1] = True
unitI (x: xs) =  if sum (diff [taille x | x<- xs]) == 0 then True else False
    where
        taille x = length [fst x .. snd x]
        

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI xs = compar [fst x | x<-xs]
        where
            compar [] = True
            compar (x:y:xs)
                    | x > y = False
                    | otherwise = compar(xs)      

--coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

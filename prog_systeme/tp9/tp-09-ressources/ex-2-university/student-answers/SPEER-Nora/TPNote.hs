import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n =[x | x <- [1..n-1] , n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n-1], x == sum (properFactors x)]

fizzBuzz :: [String]
fizzBuzz = [f x | x <- [1..]]
    where 
      f x
        | ((x `mod` 3)==0 && (x `mod` 5)==0 ) == True = "fizzbuzz"
        | (x `mod` 3) == 0 = "fizz"
        | (x `mod` 5) == 0 = "buzz"
        | otherwise = show x


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x<- [fromN..toN],y<- [fromN..toN],z<- [fromN..toN] ,z< x, (y/=x || y/=z )== True , (odd (x+y) || odd (x+z) || odd(y+z)) == True]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs)
    | p x ==True = True || any' p xs 
    | otherwise = False
    

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr (\x acc -> if p x then True || acc else acc) False xs

--group' :: Eq a => [a] -> [[a]]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = takeWhile p (iterate f x0) 

syracuse :: Int -> [Int]
syracuse n = while (>1) (\x -> if even x then x `div` 2 else x*3 +1) n

--loop :: Int -> (a -> a) -> a -> [a]
--loop k f x0 = while (<k) (iterate f x0) x0


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

--borders :: (Eq a) => [a] -> [[a]]
 
--sublists :: Int -> [a] -> [[a]]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

--intersectI :: (Int, Int) -> (Int, Int) -> Bool


-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

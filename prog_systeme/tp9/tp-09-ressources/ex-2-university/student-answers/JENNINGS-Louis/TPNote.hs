import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x<- [1.. (div n 2)] ,  (mod n x) == 0 ] 



perfects :: Int -> [Int]
perfects n = [x | x<- [1..n] , sum (properFactors x ) == x ] 

fizzBuzz :: [String]
fizzBuzz = [ go x | x <- [1..] ]
   where
     go x
       | (mod x 5 == 0 ) && (mod x 3 == 0 )= "fizzbuzz"
       | mod x 3 == 0 = "fizz"
       | mod x 5 == 0 = "buzz"
       | otherwise = show x


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN=  [ (x,y,z) | x <- [fromN..toN] , y <- [fromN..toN], z <- [fromN..toN] , z<x, y/=x || y/=z , not (even x && even y && even z) , not (odd x && odd y && odd z) ]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs) = p x || any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr (\x acc -> p x || acc) False xs 

--group' :: Eq a => [a] -> [[a]]

while :: Enum a => (a -> Bool) -> (a -> a) -> a -> [a]
while p f n = foldr (\x acc -> if p (f x) then (f x):acc else [] )[] [n..] 

syracuse :: Int -> [Int]
syracuse x = while (/=1) (\x -> if even x then div x 2 else x*3+1 ) x

--loop :: Int -> (a -> a) -> a -> [a], Int
--loop 0 _ _= []
--loop k f x = 

--
-- Exercice 3
--

-- cycle' :: [a] -> [a]

-- borders :: (Eq a) => [a] -> [[a]]

--sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x,y) (a,b) =  go [ n | n <-[x..y] , elem n [a..b]]
    where
      go [] = False
      go xs = True


unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [x] = True
unitI ((x,y):(z,w):xs) = (length [x..y] == length [z..w] ) && unitI ((z,w):xs)


isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI xs = go [ x | (x,y) <- xs ]
     where
      go [] = True
      go [x] = True
      go (x:y:xs) = x<=y && go (y:xs)



coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (x,y) (a,b) = if x < a && y<b then (x,b) else if a<=x && b<=y then (a,y) else (x,b)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

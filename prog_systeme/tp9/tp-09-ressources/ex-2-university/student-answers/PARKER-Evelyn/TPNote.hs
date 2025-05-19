import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <-[1..n], n `mod` x == 0, x<n]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n],sum (properFactors x) == x]

fizzBuzz :: [String]
fizzBuzz=[if x `mod` 3 == 0 then if x `mod` 5 == 0 then "fizzbuzz" else "fizz" else if x `mod` 5 == 0 then "buzz" else show x | x<-[1..]] 

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <-[fromN..toN],y <-[fromN..toN], z<-[fromN..toN],z<x && (y/=x || y/=z) && not (and [even x,even y, even z]) && not (and [odd x,odd y, odd z])]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' f (x:xs) = f x || any' f xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' f xs = foldr (\x acc-> acc || f x) False xs

-- group' :: Eq a => [a] -> [[a]]
-- group' xs = foldr (\x acc -> if ) [] xs

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = takeWhile p (iterate f x0) 

syracuse :: Int -> [Int]
syracuse n = while (>1) (\x -> if even x then x `div`2 else x*3+1) n ++ [1]

loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop k f x0 = x0 : loop (pred k) f (f x0)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle xs

--borders :: (Eq a) => [a] -> [[a]]

--sublists :: Int -> [a] -> [[a]]


-- select :: [a] -> [(a, [a])]
-- select xs = [(x,filter (\y -> ) xs)| x<-xs]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (a,b) (c,d)= (b>=c && b<=d) || (c>=a && c<=b) || (a>=c && a<=d) || (d>=a && d<=b)

allegal :: [Int] -> Bool
allegal [] = True
allegal [x] = True
allegal (x:y:xs) = x==y && allegal xs

unitI :: [(Int, Int)] -> Bool
unitI xs = allegal (unitI' xs)

unitI' :: [(Int, Int)] -> [Int]
unitI' xs = [b-a | (a,b)<-xs]

head' :: [(Int,Int)] -> [Int]
head' xs = [a | (a,b)<-xs]

crt' :: [Int] -> Bool
crt' [] = True 
crt' [x] = True
crt' (x:y:xs) = x<=y && crt' (y:xs)

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI xs = crt' (head' xs)

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (a,b) (c,d) = (minimum [a,b,c,d],maximum[a,b,c,d])


-- tab :: [(Int, Int)]-> [Int]
-- tab xs = [a,b| (a,b)<-xs]

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
-- coversLeftSortedI xs = (minimum (tab xs),maximum (tab xs))


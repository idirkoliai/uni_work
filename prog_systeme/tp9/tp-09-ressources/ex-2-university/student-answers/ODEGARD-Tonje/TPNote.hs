import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [m | m <- [1..n-1], n `mod` m == 0] 



perfects :: Int -> [Int] 
perfects n = [x | x <- [1..n], x == sum (properFactors x) ] 

fizzBuzz :: [String] 
fizzBuzz = [go n | n <- [1..]] 
    where 
    go k 
        | k `mod` 3 == 0 && k `mod` 5 == 0 = "fizzbuzz" 
        | k `mod` 3 == 0 = "fizz"
        | k `mod` 5 == 0 = "buzz"
        | otherwise = show k


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 n m = [(x,y,z) | x <- [n..m], y <- [n..m], z <- [n..m], x <= m && x >= n && y <= m && y >= n && z <= m && z >= n && z < x && (y /= x || y /= z), x*y*z `mod` 2 /= 0]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs) = p x == True || any' p xs 


any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr (\y acc -> (p y == True) || acc) False



--group' :: Eq a => [a] -> [[a]]       -- ici
--group' xs = foldr (\x acc -> if x == acc then [x] ++ acc else acc) [] 


while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x 
    | p x == True = (x: while p f (f x))
    | otherwise = [] 


syracuse :: Int -> [Int]
syracuse n 
    | n == 1 = [n] 
    | n `mod` 2 == 0 = (n:syracuse (n `div` 2))
    | otherwise = (n:syracuse (n*3 + 1)) 


loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ x = [x]
loop 1 _ x = [x]  
loop k f x = (f x: loop (k-1) f  (f x))

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = []
cycle' xs'@(x:xs) = xs' ++ cycle' xs' 


--borders :: (Eq a) => [a] -> [[a]]  ----- iciiiii
--borders "" = [""]
--borders xs = 


sublists :: Int -> [a] -> [[a]]  
sublists k xs = [x | x <- subsequences xs, length x == k]  


select :: [a] -> [(a, [a])]  ------------iciiiiiiiiiiii
select [] = []
select (x:[]) = [(x,[])]
select xs@(x:y:xs') = [(x,y:xs')] ++ [(y, (x:xs'))] ++ select (y:x:xs')  



--partitions :: [a] -> [[[a]]]
--partitions xs = [m ++ n | m <-subsequences xs, n <- subsequences xs, m ++ n == xs]

--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (a,b) (a',b') = (a <= a' && a' <= b) || (a >= a' && b' >= a) 


unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI (x:[]) = True 
unitI is@(i:is') = (sum (map (length) is)) == (length is * (length i))


isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI ((x,y):[]) = True
isLeftSortedI ((x,y):(x',y'):xs) = x <= x' && isLeftSortedI ((x',y'):xs) 


-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

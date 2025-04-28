import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1] ,mod n x == 0]  

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n] ,sum (properFactors n ) == n]

fizzBuzz :: [String]
fizzBuzz  =  [if (mod x 15 == 0) then "fizzbuzz" else if (mod x 3 == 0) then "fizz" else if (mod x 5 == 0) then "buzz" else show x | x <- [1..] ]  

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x , y , z)  | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..x-1] , odd x , even y ] -- pas réussi les odd et even  

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' f xs =  head [f x | x <- xs ] 

-- any pas réussie donc mise en commentaire

--any'' :: (a -> Bool) -> [a] -> Bool
--any'' f xs = foldr (\x acc -> if f x then True else acc )False

group' :: Eq a => [a] -> [[a]]
group' = foldr (\x acc -> [[x]]++acc   )[]

--while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while f g i = [[1..i]] 


-- syracuse :: Int -> [Int]
-- syracuse x = 
-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = error "cycle : empty list"
cycle' xs = xs ++ cycle' xs

borders :: (Eq a) => [a] -> [[a]]
borders [] = []
borders x = [x]

--sublists :: Int -> [a] -> [[a]]
--sublists i x:xs = 
-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (w,x) (y,z)
	| x < w = False
	| z < y = False
	| w < y = intersectI (w+1,x)(y,z)
	| y < w = intersectI (w,x)(y+1,z)
	|otherwise = True


unitI :: [(Int, Int)] -> [Int]
unitI [(x,y)] = [z-i | (z,i) <- [(x,y)] ]
	


isLeftSortedI :: [(Int, Int)] -> [Int]
isLeftSortedI [xs] = [x | (x,s) <- [xs] ]

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

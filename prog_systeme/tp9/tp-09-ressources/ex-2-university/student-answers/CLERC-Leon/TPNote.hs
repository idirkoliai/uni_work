import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFacotrs x = [x| x <- take n $ iterate (+1) 0, n mod x == 0]

perfects :: Int -> [Int]
perfects x = [x| y <- take n $ iterate (+1) 0, x <- (properFacotrs y), foldr(+) 0 [x] == y]

fizzBuzz :: [String]
fizzBuzz S = [x| x <- iterate (+1) 1]
	show S where
		if x mod 15 == 0 then "fizzbuzz"somme
		else if x mod 5 == 0 then "buzz" 
		else if x mod 3 == 0 then "fizzbuzz"

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 x y z = [x y z| x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x, (y == x)== False, (y == z)== False]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _[] = []
any' p (x:xs)
	p x = x:any' p xs
	True = any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p x = foldr(p) [] [x|x <- xs, xs == True]

group' :: Eq a => [a] -> [[a]]
group' xs = foldr(x == y) [][x|x <- xs, y <- xs,x == y]


while :: (a -> Bool) -> (a -> a) -> a -> [a]
while [x|x <- (iterate (f) x0), length(map(p) x)== length(x)]
	
syracuse :: Int -> [Int]
syracuse liste = []
	if n mod n == 0 then concat [liste, while (n==1) (n/2) syracuse n]
	else liste = concat [liste, while (n==1) (n+1) syracuse n]

loop :: Int -> (a -> a) -> a -> [a]
loop [n] = take k iterate (f) x0


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' repeat[a]

--borders :: (Eq a) => [a] -> [[a]]

sublists :: Int -> [a] -> [[a]]
subList [x|x <- [y],y <- [liste], length([y]) == length([liste], nub[x]]

select :: [a] -> [(a, [a])]
select listes = [x|x<-rotate[xs]]
select heads = [x|x<-head[listes]]
select tails = [x|x<-tails[listes]]  
select zipWith(,) heads [tails]

partitions :: [a] -> [[[a]]]
partitions listes = [l|l <- liste, listes <- subList length(liste) l ]

--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI if head i1 > head i2 && head i1 < head $ reverse i2 then True
	else if head i2 > head i1 && head i2 < head $ reverse i1 then True
	else False
	

-- unitI :: [(Int, Int)] -> Bool
-- unitI is [(a,b)]
-- unitI l = b - a
-- unitI [x|x<

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

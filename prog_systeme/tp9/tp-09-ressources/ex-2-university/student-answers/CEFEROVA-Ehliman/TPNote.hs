import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x<- [1..n],n`mod`x == 0,x/=n]


perfects :: Int -> [Int]
perfects n = [k | k<-[1..n], sum(properFactors k) == k]

--fizzBuzz :: [String] la fonction semble correcte il faut juste savoir comment donner une valeur précise a x
--fizzBuzz = [show x | x<- [1..], if x `mod` 3 == 0 then x="fizz" else if x `mod` 5 == 0 then x= "buzz" else if (x `mod`5 ==0) && x `mod` 3 == 0 then x= "fizzbuzz" else show x]


--altParity3 :: Int -> Int -> [(Int, Int, Int)]
--altParity n k = [(x,y,z) | x,y,z <- [n..k], ]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [x] = False
any' p (x:xs) = if p x then True else any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr (\x acc -> if p x then True else acc) False xs

group' :: Eq a => [a] -> [[a]]
group' xs = foldr(\x acc -> if x == (head acc) then acc++[x] else acc ) [[]] xs

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 =  if p x0 then iterate(f) x0 else []


--syracuse :: Int -> [Int]
--syracuse n = while (==1) (if even n then n%2 else n*3+1) n

--loop :: Int -> (a -> a) -> a -> [a]
--loop 0 f k = []
--loop n f k = loop (n-1) f k ++ n:iterate(f) k


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs 

--borders :: (Eq a) => [a] -> [[a]]
--borders "" = [""]
--borders [x] = ["","x"]
--boders (x:xs) = boders xs ++ x 

--sublists :: Int -> [a] -> [[a]] -- il faut arriver a faire en sorte que n diminue petit a petit et qu'on prennent une longueur de n 
--sublists 0 _ = [[]]
--sublists k xs = 

select :: [a] -> [(a, [a])]
select [] = []
select [x] = [(x,[])]
select (x:y:xs) = (x,[y]) : (y,[x]) : select (xs)

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

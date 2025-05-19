import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors 0 = []
properFactors 1 = []
properFactors x = [y | y <- [1..x-1], mod x y == 0 ]

perfects :: Int -> [Int]
perfects 0 = []
perfects 1 = []
perfects x = [y | y <- [1..x-1], (sum (properFactors y)) == y]


-- fonctionne pas car if = bool , logique
--fizzBuzz :: [String]
-- fizzBuzz = [x | x <- "buzz", mod3 x, x<- "fizz" mod6 x, x<- "fizzBuzz", mod3 x && mod6 x]     ligne test

--fizzBuzz = [x | x <-  if mod3 x then if mod6 x then "fizzbuzz" else "fizz" else if mod6 x then "buzz" else show x ]
--    where
--       mod3 n = mod n 3
--       mod6 n = mod n 6 


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x<-[fromN..toN], y<-[fromN..toN], z<-[fromN..toN], z<x, y /= x || y /= z, odd x /= odd y || odd x /= odd z]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [x] = p x 
any' p (x:xs) = p x || any' p xs  

--any'' :: (a -> Bool) -> [a] -> Bool
--any'' f (x:xs) = foldr f True xs     


-- group' :: Eq a => [a] -> [[a]]
--group'(x:xs) = [z | z <- foldr(\w -> [l |l <- x ,x == w] ) x xs ]


--while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while _ _ x0 = [x0]
--while p f x0 = filter p x0 : while p  f (f x0) 

--intestable car while pas bon
--syracuse :: Int -> [Int]
--syracuse x = while (>1) (\x -> if even x then x/2 else x*3 + 1) x


--loop :: Int -> (a -> a) -> a -> [a], Int)
 


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' lst = lst ++ cycle' lst

--borders :: (Eq a) => [a] -> [[a]]
--borders "" = [""]
--borders "_" = ["", "_"]
--borders (x:xs) = isPrefixOf x:borders xs x:xs && isSuffixOf x:borders xs x:xs 

--sublists :: Int -> [a] -> [[a]]
--sublists 0 [] = [[]]
--sublists k xs = [x | x <- ,y<- []  ,length x == k ] 

--select :: [a] -> [(a, [a])]
--select [] = []
--select [_] = [(_,[])]
--select (x:xs) = select x : select xs  

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

--intersectI :: (Int, Int) -> (Int, Int) -> Bool
--intersectI i1 i2 = min(min(i1) min (i2)) < min( max(i1) max(i2))

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors a = [x | x<-[1..a], mod a x == 0 && x/=a ]

somme :: [Int] -> Int
somme [] = 0
somme (x:xs) = x+ somme xs

perfects :: Int -> [Int]
perfects a = [x|x<-[1..a], somme (properFactors x )== x  ]

--fizzBuzz :: [String]
--fizzBuzz = [ s x | x<- [1..]]
    --where
        --s x  = if (mod x 5) /= 0 && (mod x 3) /= 0  then show x
               --else if (mod x 3 ) /= 0 then "fizz"
                    -- else  (mod x 3 ) /= 0


-- altParity3 :: Int -> Int -> [(Int, Int, Int)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' f (x:xs) 
    |  f x = True
    |otherwise = any' f xs 

any'' :: (a -> Bool) -> [a] -> Bool
any'' f a = foldr s False a
    where
      s x acc  = if f x then True else acc

--group' :: Eq a => [a] -> [[a]]
--group' = foldr s []
    --Where
      --  s x acc = 

--while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while f f1 a = foldr s [] [a]
    --where
        --s x acc = if f x then x :acc else acc

--syracuse :: Int -> [Int]
--syracuse a  = while (==1) (\x -> if even x then x/2 else x*3+1 ) a


--loop :: Int -> (a -> a) -> a -> [a]




--
-- Exercice 3
--

--cycle' :: [a] -> [a]
--cycle' [] = []
--cycle' a = a : cycle' a
 
-- borders :: (Eq a) => [a] -> [[a]]

--sublists :: Int -> [a] -> [[a]]
--sublists a [] = [[]]
--sublists z (x:xs) =sublists z xs ++ map(x: ) sublists z xs

supp :: Eq a => a -> [a] -> [a]
supp _ [] = []
supp a (b:bx) 
    | a == b = supp  a bx
    | otherwise = b : supp a bx

select :: Eq a => [a] -> [(a, [a])]
select a = [(x, supp x a)| x <- a]
 
-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (a,b) (c,d) 
    |   (a<= c && c<=b  || a<= d && d<=b) || (c<= a && a<=d  || c<= b && b<=d)  = True
    |otherwise = False

longeur :: (Int,Int) -> Int
longeur (a,b) = b-a 

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [a] = True
unitI (x:xs) 
    | longeur x == longeur (head xs) = unitI xs
    |otherwise = False


recc :: (Int,Int) -> Int
recc (a,b) = a

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [a] = True
isLeftSortedI (x:xs)
    | recc x <= recc (head xs) = unitI xs
    |otherwise = False

min' :: (Int,Int) -> Int
min' (a,b)
    | a<b = a
    | otherwise =b

minimum' :: (Int,Int) -> (Int,Int) -> Int
minimum' a b
    | min' a < min' b = min' a
    |otherwise = min' b

max' :: (Int,Int) -> Int
max' (a,b)
    | a<b = b
    | otherwise =a

maximum' :: (Int,Int) -> (Int,Int) -> Int
maximum' a b
    | max' a < max' b = max' b
    |otherwise = max' a



coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI a b  = (minimum' a b , maximum' a b)



-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

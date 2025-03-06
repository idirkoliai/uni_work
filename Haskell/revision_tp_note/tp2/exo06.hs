import Data.List

sum' :: (Num a) => [a] -> a
sum' xs = go xs 0
    where   
        go [] n = n
        go (x:xs) n = go xs (n + x)

sum'' ::(Num a) => [a] -> a
sum'' = foldr (+) 0

maximum' :: Ord a => [a] -> a
maximum' (x:xs) = go xs x
    where
        go [] max = max
        go (x:xs) max 
            | x>max = go xs x
            |otherwise = go xs max

length' :: [a] -> Int
length' xs = go xs 0
    where 
        go [] len = len
        go (_:xs) len = go xs (len + 1)

zip' :: [a] -> [b] -> [(a, b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y) : zip' xs ys

take' :: (Eq b, Num b) => b -> [a] -> [a]
take' 0 _ = []
take' _ [] = []
take' n (x:xs) = x: take' (n-1) xs 

drop' :: (Eq b, Num b) => b -> [a] -> [a]
drop' 0 xs = xs
drop' _ [] = []
drop' n (x:xs) = drop'(n-1) xs

elem' :: Eq a => a -> [a] -> Bool
elem' _ [] = False
elem' elm (x:xs) = x == elm || elem' elm xs

reverse' :: [a] -> [a]
reverse' [] = []
reverse' [x] = [x]
reverse' (x:xs) = reverse' xs ++ [x]

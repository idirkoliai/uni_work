import Data.List
import Distribution.Simple.Utils (xargs)
elem' :: (Eq a) =>a -> [a] -> Bool
elem' x  = foldr f False 
  where
    f y acc = if acc then acc else y == x

map1 :: (a -> b) -> [a] -> [b]
map1 _ [] = []
map1 f (x:xs) = f x : map1 f xs

map2 :: (a -> b) -> [a] -> [b]
map2 f xs = [f x | x<- xs]

map3 :: (a -> b) -> [a] -> [b]
map3 f  = foldr  g []
    where 
        g x acc = f x : acc

map4 :: (a -> b) -> [a] -> [b]
map4 f = reverse . foldl (\acc x -> f x : acc) []

filter1 :: (a -> Bool) -> [a] -> [a]
filter1 _ [] = []
filter1 f (x:xs)
    | f x = x : filter1 f xs
    | otherwise = filter1 f xs

filter2 :: (a -> Bool) -> [a] -> [a]
filter2 f xs = [x | x<-xs ,f x]

filter3 :: (a -> Bool) -> [a] -> [a]
filter3 f  = foldr (\x acc -> if f x then x:acc else acc) [] 


filter4 :: (a -> Bool) -> [a] -> [a]
filter4 f  = reverse . foldl (\acc x -> if f x then x:acc else acc) []

takeWhile1 :: (a -> Bool) -> [a] -> [a]
takeWhile1 _ [] = []
takeWhile1 f (x:xs)
    | f x = x : takeWhile1 f xs
    |otherwise = []

takeWhile2 :: (a -> Bool) -> [a] -> [a]
takeWhile2 f = foldr (\x acc -> if f x then x:acc else []) []

dropWhile1 :: (a -> Bool) -> [a] -> [a]
dropWhile1 _ [] = []
dropWhile1 f xs@(x:xs')
    | f x = dropWhile1 f xs'
    |otherwise = xs

dropWhile2 :: (a -> Bool) -> [a] -> [a]
dropWhile2 f = reverse.snd . foldl g (False,[])
    where 
        g (flag,acc) x 
            | flag = (flag,x:acc) 
            |not $ f x = (True,x:acc)
            |otherwise = (False,acc)


zipWith1 :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith1 _ [] _ = []
zipWith1 _ _ []  = []
zipWith1 f (x:xs) (y:ys) = f x y : zipWith1 f xs ys

zipWith2 :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith2 f xs ys = [f x y | (x,y) <- zip xs ys ]
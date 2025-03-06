import Data.List
--elem' with a fold
elem' :: (Eq a) => a -> [a] -> Bool
elem' x xs = foldl (\acc y -> if x == y then True else acc) False xs

--map1

map1 :: (a -> b) -> [a] -> [b]
map1 f [] = []
map1 f (x:xs) = (f x) : map1  f xs

--map2

map2 :: (a -> b) -> [a] -> [b]
map2 f xs = [f x | x <- xs ] 

--map3
map3 :: (a -> b) -> [a] -> [b]
map3 f xs = foldr(\x acc -> f x:acc) [] xs

--filter 1 

filter1 :: (a -> Bool) -> [a] -> [a]
filter1 f [] = []
filter1 f (x:xs) 
    | f x == False = filter1 f xs 
    | f x = x : filter1 f xs

--filer2 with list comprehension

filter2 :: (a -> Bool) -> [a] -> [a]
filter2 f xs = [x | x <- xs, f x]

filter3 :: (a -> Bool) -> [a] -> [a]
filter3 f xs = foldr (\x acc -> if f x then x:acc else acc) [] xs

takeWhile2 :: (a -> Bool) -> [a] -> [a]
takeWhile2 f xs = foldr (\x acc -> if f x then x:acc else []) [] xs

dropWhile2 ::(a -> Bool) -> [a] -> [a]
dropWhile2 f xs = fst (foldl (\(acc,flag) x  -> if flag && f x then ([],flag) else (acc ++ [x],False) ) ([],True) xs)

zipWith2 :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith2 f xs ys = foldr(\(x,y) acc -> (f x y) : acc ) [] (zip xs ys)


reverse2 :: [a] -> [a]
reverse2 xs = foldl (\acc x -> x:acc) [] xs

reverse3 :: [a] -> [a]
reverse3 xs = foldr (\x acc -> acc++[x]) [] xs

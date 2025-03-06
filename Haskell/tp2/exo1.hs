import Data.List
head2 :: [a] -> a
head2 (x:_)  =  x 

tail2 :: [a] -> [a]
tail2 (_:xs) = xs

last2 :: [a] -> a
last2 [x] = x
last2 (_:xs) = last2 xs

--crashes if the list is empty

interval ::(Eq a, Num a) => a -> [a]
interval k 
    | k == 0 = []
    | otherwise =  interval (k-1) ++ [k]

interval2 ::(Eq a, Num a,Ord a) => a -> [a]
interval2 n = go [] n 
    where 
        go acc k 
            | k < 1 = acc 
            | otherwise = go(k:acc) (k-1) 
        
interval3 ::(Eq a, Num a,Ord a) => a -> a -> [a]
interval3 inf sup = go [] sup
    where 
        go acc k 
            | k < inf = acc
            | otherwise = go(k:acc) (k-1) 

isPalindrome :: Eq a => [a] -> Bool
isPalindrome xs = xs == reverse(xs)

pairs :: [a] -> [(a,a)]
pairs xs = go xs []
    where 
        go [_] acc = acc
        go (x:xs) acc = (x,head(xs)) : go xs acc

pairs2 :: [a] -> [(a,a)]
pairs2 xs = [(x,y) | (x,y) <- zip xs (tail xs)]


pairs3 :: [a] -> [(a, a)]
pairs3 xs = zip xs (tail xs)


prefixes :: [a] -> [[a]]
prefixes xs = tail(inits(xs))

factors :: [a] -> [[a]] 
factors [] = [[]]
factors xs = prefixes xs ++ factors (tail(xs))

factors2 :: [a] -> [[a]]
factors2 xs = [take k (drop i xs) | i <- [0..length xs], k <- [1..length xs - i]] ++ [[]]


subseqs :: [a] -> [[a]]
subseqs [] = [[]]
subseqs (x:xs) = subseqs xs ++ [x:ys | ys <- subseqs xs]


isArithSerie :: (Eq a, Num a) => [a] -> Bool
isArithSerie [] = True
isArithSerie [_] = True 
isArithSerie [_,_] = True 
isArithSerie (x:y:z:xs) = (y - x) == (z - y) && isArithSerie (y:z:xs)


mkArithSerie :: (Eq a, Num a) => a -> a -> a -> [a]
mkArithSerie u r n = go u r 0 []
    where 
        go u r k acc
            | n == k = acc
            | otherwise = u:(go (u+r) r (k+1) (acc))






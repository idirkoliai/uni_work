import Data.List
isPalindrome :: Eq a => [a] -> Bool
isPalindrome xs = xs == reverse xs 


pairs :: [Int] -> [(Int,Int)]
pairs xs = zip xs $ tail xs


pairs2 ::  [Int] -> [(Int,Int)]
pairs2 [] = []
pairs2 [_] = []
pairs2 xs@(x:xs'@(x':xs'')) = (x,x') : pairs2 xs'

prefixes :: [a] -> [[a]]
prefixes [] = [[]]
--prefixes xs = tail $ inits xs
prefixes [x] = [[x]]
prefixes xs =   prefixes (init xs) ++ [xs]  

prefixes2 :: [a] -> [[a]]
prefixes2 xs = [ take i xs | i <- [1..length xs -1]   ]


factors :: [a] -> [[a]]
factors [] = [[]]
factors xs = prefixes xs ++ factors (tail xs)

factors2 :: [a] -> [[a]]
factors2 xs =  [ take j $ drop i xs| i <- [0..length xs -1] , j <- [1..length xs -i]] ++ [[]]


subseqs :: [a] -> [[a]]
subseqs [] = [[]]
subseqs (x:xs) = subseqs xs ++ [x:ys | ys <- subseqs xs]
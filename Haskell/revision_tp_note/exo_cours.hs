import Control.Monad (when)
import Data.Char (isSpace)

binomial :: Int -> Int -> Int
binomial n k = fact n `div` (fact k * fact (n - k))
  where
    fact n = if n == 0 then 1 else n * fact (n - 1)

uncurry' :: (a -> b -> c) -> (a, b) -> c
uncurry' f (x, y) = f x y

curry' :: ((a, b) -> c) -> a -> b -> c
curry' f x y = f (x, y)

hasSpace :: String -> Bool
hasSpace [] = False
hasSpace (x : xs) = isSpace x || hasSpace xs

hasSpace' :: String -> Bool
hasSpace' = foldr (\x acc -> isSpace x || acc) False

max4 :: Int -> Int -> Int -> Int -> Int
max4 w x y z
  | w > y && w > x && w > z = w
  | x > y && x > z = z
  | y > z = y
  | otherwise = z

intersperse' :: a -> [a] -> [a]
-- intersperse' _ [] = []
-- intersperse' _ [x] = [x]
-- intersperse' x' (x:xs) = x:x':intersperse' x' xs
intersperse' x' = foldr (\x acc -> if null acc then x : acc else x : x' : acc) []

intercalate' :: [a] -> [[a]] -> [a]
-- intercalate' _ [[]] = []
-- intercalate' _ [x] = x
-- intercalate' ys (xs:xss) = xs ++ ys ++ intercalate' ys xss
intercalate' ys xss@(xs : xss') = foldr (\x acc -> if null acc then xs ++ acc else xs ++ ys ++ acc) [] xss

pT :: (Num a, Ord a, Num b) => a -> a -> b
pT n k
  | n == 1 && k == 1 = 1
  | k < 1 || k > n = 0
  | otherwise = pT (n - 1) (k - 1) + pT (n - 1) k

divisors :: Int -> [Int]
divisors n = [n' | n' <- [1 .. n - 1], n `mod` n' == 0]

perfects :: Int -> [Int]
perfects k = [n | n <- [1 .. k], sum (divisors n) == n]

tails' :: [a] -> [[a]]
tails' [] = [[]]
tails' xs@(_ : xs') = tails' xs' ++ [xs]

remDups :: (Eq a) => [a] -> [a]
remDups = reverse.foldl (\acc x -> if x `elem` acc then acc else x:acc ) []
import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..pred n], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], (sum (properFactors x)) == x]

fizzBuzz :: [String]
fizzBuzz = [fizzBuzzAux x| x <- [1..]]
  where
    c1 x = (mod x 3) == 0
    c2 x = (mod x 5) == 0 
    fizzBuzzAux x
      | c1 x && c2 x = "fizzbuzz"
      | c1 x = "fizz"
      | c2 x = "buzz"
      | otherwise = show x

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x<- [fromN..toN] , y <- [fromN..toN], z <- [fromN..toN], (z<x && (y/=z || y/=x) && not (sameParity x y z))]
  where
    sameParity x y z = even x == even y && even y == even z

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs) = p x || any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr (\x acc -> p x || acc) False xs

group' :: Eq a => [a] -> [[a]]
--group' xs = foldr (\x acc -> if length acc > 0 && ((head (last acc)) == x) then (init acc)++[x:(last acc)] else acc++[[x]]) [] xs
group' xs = foldr (\x acc -> if length acc > 0 && ((head (head acc)) == x) then (x:(head acc)):(tail acc) else [x]:acc) [] xs

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0
  | p x0 = x0:while p f (f x0)
  | otherwise = []

syracuse :: Int -> [Int]
syracuse n = (while (\x -> x /= 1) f n) ++ [1]
  where
    f :: Int -> Int
    f x
      | even x = div x 2
      | otherwise = x*3 + 1

--loop :: Int -> (a -> a) -> a -> [a]
--loop k f x0 = while (\x -> x /= repf f k x0) f x0

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs++cycle' xs 

borders :: (Eq a) => [a] -> [[a]]
borders xs = [take l xs | l <- [1..length xs], (take l xs) == reverse (take l (reverse xs))]

sublists :: (Eq a) => Int -> [a] -> [[a]]
sublist n [] = []
sublists 0 xs = []
sublists 1 xs = [[x] | x <- xs]
sublists n [x] = []
sublists n (x:xs) = [x:l | l <- sublists (pred n) xs] ++ sublists n xs

select :: [a] -> [(a, [a])]
select [] = []
select (x:xs) = (x, xs):([(y, x:ys)  | (y, ys) <- select xs]) 

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

unitI :: [(Int, Int)] -> Bool
unitI [(x,y)] = True
unitI ((x,y):(x2,y2):xs) = (if (x-y) == (x2-y2) then True else False) && unitI ((x2,y2):xs)

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

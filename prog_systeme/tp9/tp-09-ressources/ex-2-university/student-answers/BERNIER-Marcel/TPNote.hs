import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors x = [y | y <- [1..x-1], x `mod` y == 0]

perfects :: Int -> [Int]
perfects x = [y | y <- [1..x], sum (properFactors y) == y]

test :: Int-> String
test x = if x `mod` 5 ==0 && x`mod`3 == 0 then "fizzbuzz" else if x `mod`3 == 0 then "fizz" else if x`mod`5 == 0 then "buzz" else show x


fizzBuzz :: [String]
fizzBuzz = [test x | x <- [1..]]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 m n = [(x,y,z) | x <- [m..n], y <- [m..n], z <- [m..x-1], y/=x || y/=z, if (odd x && odd y && odd z) then False else True , if (even x && even y && even z) then False else True ]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs) = if p x then True else any' p xs


--any'' :: (a -> Bool) -> [a] -> Bool
--any'' p xs = foldr(\x -> if p x then True) False

--group' :: Eq a => [a] -> [[a]]
--group' xs = foldr(\x acc -> if x == head acc then x:acc else acc)[]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = if (p x0) then x0: (while p f (f x0)) else []

--syracuse :: Int -> [Int]
--syracuse x = while (>=1) (\x -> if x `mod` 2 == 0 then ( `div` 2) else (+2)) x


loop :: Int -> (a -> a) -> a -> [a]
loop 0 f x0 = []
loop k f x0 = x0 : loop (k-1) f (f x0)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

borders :: (Eq a) => [a] -> [[a]]
borders [] = [""]
borders xs = (init xs) ++ xs

--sublists :: Int -> [a] -> [[a]]
--sublists k xs = []
--sublists k (x:xs) = 




tmp :: [Int]-> Int -> [Int]
tmp xs k = [x | x <- xs, x /= k]


--select :: [a] -> [(a, [a])]
--select xs = [(y,tmp xs y) |  y <- xs]


-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x,y) (n,m) = if (x > n && x < m) || (y>n && y < m) || (n>x && m < y) || (x>n && y<m) then True else False


--unitI :: [(Int, Int)] -> Bool
--unitI [] = True
--unitI [(x,y)] = True
--unitI (x:xs) = if sum 

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], rem n x == 0]


perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], (sum (properFactors x)) == x]

fizzBuzz :: [String]
fizzBuzz = [if(rem x 3 == 0 && rem x 5 == 0) then "fizzbuzz" else if (rem x 3 == 0) then "fizz" else if (rem x 5 == 0) then "buzz" else show x | x<- [1..]]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], compliance x y z]
 where
  compliance :: Int -> Int -> Int -> Bool
  compliance x y z = z<x && (y/=x || y/=z) && (not(even x && even y && even z)) &&(not(odd x && odd y && odd z))

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' f (x:xs) = f x || any' f xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' f xs = foldr (\x acc -> acc || f x) False xs

-- group' :: Eq a => [a] -> [[a]]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while v f x =if v (f x) then x:calc v f (f x) else []
 where
  calc v f x =if v (f x) then x:calc v f (f x) else [x] 

syracuse :: Int -> [Int]
syracuse n = while (\x-> x /= 1) (\x-> if rem x 2 ==0 then div x 2 else x*3 +1) n ++ [1]

loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop k f x0 = x0 : loop (k-1) f (f x0)

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs++cycle' xs

--borders :: (Eq a) => [a] -> [[a]]


-- sublists :: Int -> [a] -> [[a]]


select :: [a] -> [(a, [a])]
select xs = [(getK y xs, remK y xs) | y<- [0..length xs-1]]
 where
  getK :: Int -> [a] -> a
  getK 0 xs = head xs
  getK k (_:xs) = getK (k-1) xs

  remK :: Int -> [a] -> [a]
  remK 0 (_:xs) = xs
  remK k (x:xs) = x:remK (k-1) xs

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (xa,xb) (ya,yb)
 | xa<=yb &&  xb>=yb = True
 | xa <=ya && xb>=ya = True
 | ya<=xb && yb>=xb = True
 | ya<=xa && yb>=xa = True
 | otherwise = False

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI ((x,y):xs) = verify (y-x) xs
 where
  verify ::Int-> [(Int, Int)] -> Bool
  verify _ [] = True
  verify n ((x,y):xs) = if n==(y-x) then True && verify n xs else False

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [a] = True
isLeftSortedI (x:xs) = if getLeft x <= getLeft (head xs) then True && isLeftSortedI xs else False
 where
  getLeft :: (Int, Int) -> Int
  getLeft (x,y) = x

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (i1, i2) (j1, j2) = (min i1 j1, max i2 j2)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

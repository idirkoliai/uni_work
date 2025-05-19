import           Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]
properFactors k = 1:[ x | x <- [2..(k - 1)], k `mod` x == 0]

-- perfects :: Int -> [Int]
perfects n = [ x | x <- [2..n], sum (properFactors x) == x]

-- fizzBuzz :: [String]
fizzBuzz = [f x | x <- [1..]]
 where
  f x 
   | x `mod` 3 == 0 && x `mod` 5 == 0 = "fizzbuzz"
   | x `mod` 3 == 0 = "fizz"
   | x `mod` 5 == 0 = "buzz"
   | otherwise = show x
-- altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN =  [(x,y,z) | x <- [fromN..toN], z <- [fromN..(x-1)],y <- [fromN..toN], y /= x || y /= z, f x y z ]
 where
  f x y z = odd x /= odd y || odd x /= odd z || odd y /= odd z

--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool
any' p xs = f p xs
  where 
   f _ [] = False
   f p (x:xs)
    | p x = True
    | otherwise = f p xs
-- any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr (g p) False xs
 where
 g p x acc
   | p x = True
   | otherwise = acc

-- group' :: Eq a => [a] -> [[a]]
group' xs = foldr sousList [] xs
  where 
   sousList x acc 
    | acc == [] || x == head acc = x:acc
    | otherwise = []
  

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = if p x0 then x0 : while p f (f x0) else []

-- syracuse :: Int -> [Int]
syracuse n = concat [while (/= 1) syra n, [1]]
 where 
  syra n
   | even n = div n 2
   | otherwise = n*3 + 1


-- loop :: Int -> (a -> a) -> a -> [a], Int)
loop 0 _ _ = []
loop k f x0 = x0 : loop (k-1) f (f x0)

--
-- Exercice 3
--

-- cycle' :: [a] -> [a]
cycle' xs = f xs xs
 where
  f [] origine = f origine origine
  f (x:xs) origine = x : f xs origine
  
-- borders :: (Eq a) => [a] -> [[a]]


-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x1,x2) (y1,y2) = x1 >= y1 && x1 <= y2 || x2 >= y1 && x2 <= y2 || x1 <= y1 && y1 <= x2 || x1 <= y2 && y2 <= x2

-- unitI :: [(Int, Int)] -> Bool
-- unitI [] = True
-- unitI xs = let x = head xs in f x (tail xs)
-- where 
-- f _ [] = True
--  f (x1,y1) xs = g (y1 - x1) xs
--  where 
--   g _ [] = True
--   g k x:xs
--    | k == size xs = g k xs
--    | otherwise = False
--   where 
--    size (x1,y1) = y1 -x1
-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

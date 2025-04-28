import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1],n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <-[1..n],sum (properFactors x) == x]

--fizzBuzz :: [String]
--fizzBuzz = [x| x [1..],x `mod` 3 == 0]
altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <-[fromN..toN],y <-[fromN..toN],z <-[fromN..toN],z<x,y/=x || y/=z]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs)
  | p x = True
  | otherwise = any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr (\x acc -> p x || acc) False xs

--group' :: Eq a => [a] -> [[a]]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = takeWhile p $ x0:newlst f x0
  where
    newlst f x0 = f x0 : newlst f (f x0)

syracuse2 x
  | x == 1 = 0
  | x `mod` 2 == 0 = x `div` 2
  | otherwise = x*3+1

syracuse :: Int -> [Int]
syracuse n = while (/= 0) (\x -> syracuse2 x) n

loop :: Int -> (a -> a) -> a -> [a]
loop k f x0 = take k $ x0:newlst f x0
  where
    newlst f x0 = f x0 : newlst f (f x0)

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = cycle xs ++ xs

--borders :: (Eq a) => [a] -> [[a]]

--sublists :: Int -> [a] -> [[a]]

--select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI i1 i2 = inter i1 i2
  where
    inter (x1,y1) (x2,y2)
      | x1 >= x2 && x1 <= y2 = True
      | x1 == y1 = False
      | otherwise = inter (x1 + 1,y1) (x2,y2)


unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [x] = True
unitI (x:y:xs) = cheklenght x y && unitI (y:xs)
  where
    cheklenght (x1,x2) (y1,y2)
      | x2 - x1 == y2 - y1 = True
      | otherwise = False
isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [x] = True
isLeftSortedI (x:y:is) = cheksort x y && isLeftSortedI (y:is)
  where
    cheksort (x1,x2) (y1,y2)
      | x1 <= y1 = True
      | otherwise = False

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI i1 i2 = takeminmax i1 i2
  where
    takeminmax (x1,x2) (y1,y2) = (min x1 y1,max x2 y2)

coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [x] = [x]
coversLeftSortedI (x:y:xs)
  | intersectI x y = coversLeftSortedI ((coverI x y):xs)
  | otherwise = x:coversLeftSortedI (y:xs)

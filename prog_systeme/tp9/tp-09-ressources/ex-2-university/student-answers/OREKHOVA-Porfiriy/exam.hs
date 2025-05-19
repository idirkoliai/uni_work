import           Data.List


--
-- Exercice 1
--

-------------------------------------------------------
properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1] , n `mod` x == 0]
-------------------------------------------------------

----------------------------------------------------------
perfects :: Int -> [Int]
perfects n = [ x | x <- [1..n], sum(properFactors x)==x]
-----------------------------------------------------------

-- fizzBuzz :: [String]

-----------------------------------------------------------------------------
allEven :: Int -> Int -> Int -> Bool
allEven x y z = if even x && even y && even z then True else False

allOdd :: Int -> Int -> Int -> Bool
allOdd x y z = if odd x && odd y && odd z then True else False

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z<x && (y/=x || y/=z) && allEven x y z == False && allOdd x y z == False]
-------------------------------------------------------------------------------


--
-- Exercice 2
--

----------------------------------------------------------
--en utilisant filter
any1 :: (a -> Bool) -> [a] -> Bool
any1 p xs = length(filter p xs) /=0
----------------------------------------------------------

----------------------------------------------------------
--en utilisant la récursivité
any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs) 
    | p x = True
    | otherwise = any' p xs
----------------------------------------------------------

----------------------------------------------------------
--en utilisant foldr
any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = foldr f False xs
    where
        f x acc
            | p x = True
            | otherwise = acc
----------------------------------------------------------

----------------------------------------------------------
--group' :: Eq a => [a] -> [[a]]
----------------------------------------------------------

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)




--
-- Exercice 3
--

-------------------------------
cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs
-------------------------------

----------------------------------
borders :: (Eq a) => [a] -> [[a]]
borders [] = [[]]
borders xs = [xs]
----------------------------------

-----------------------------------------------------------------
sublists :: Int -> [a] -> [[a]]
sublists 0 [] = [[]]
sublists _ [] = []
sublists k (x:xs)
    | k < 0 = []
    | otherwise = map (x:) (sublists (k-1) xs) ++ sublists k xs
------------------------------------------------------------------


-------------------------------------------------
select :: [a] -> [(a, [a])]
select [] = []
select (x:xs) = [(x, head(sublists (length(xs)) xs))] ++ select xs
-------------------------------------------------

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-------------------------------------------------
--intersectI :: (Int, Int) -> (Int, Int) -> Bool

-------------------------------------------------

--------------------------------------------------
isConstant :: (Eq a) => [a]-> Bool
isConstant [] = True
isConstant [x] = True
isConstant (x:y:xs)
    | x==y = isConstant (y:xs)
    | otherwise = False

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI xs = isConstant[x'-x | (x,x') <- xs]

---------------------------------------------------

---------------------------------------------------
isSorted :: (Ord a) => [a] -> Bool
isSorted [] = True
isSorted [x] = True
isSorted (x:y:xs)
    | x<=y = isSorted (y:xs)
    | otherwise = False

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI xs = isSorted[x | (x,x') <- xs]
-----------------------------------------------------

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

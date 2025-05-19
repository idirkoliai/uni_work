import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors 0 = []
properFactors n = [x | x <- [1..n-1], func x]
    where
        func x = n `mod` x == 0


perfects :: Int -> [Int]
perfects 0 = []
perfects n = perfects (n - 1) ++ cond n
    where
        cond k
            | k == sum (properFactors k) = [k]
            | otherwise = [] 


-- to do
-- fizzBuzz :: [String]
-- fizzBuzz = let xs = iterate (+1) 1

generatePairs :: Int -> Int -> [(Int, Int, Int)]
generatePairs xMin xMax = [(x, y, z) | x <- [xMin..xMax], y  <- [xMin..xMax], z <- [xMin..xMax]]

notSameParity :: Int -> Int -> Int -> Bool
notSameParity x y z = not ((odd x && odd y && odd z) || (even x && even y && even z))

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 xMin xMax = filter func (generatePairs xMin xMax)
    where
        func (x, y, z) = z < x && (y /= x || y /= z) && notSameParity x y z


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f (x : xs)
    | f x = True || any' f xs
    | otherwise = False || any' f xs

-- TO DO
--any'' :: (a -> Bool) -> [a] -> Bool
--any'' f xs = foldr (\x acc -> f x) []

-- TO DO
-- group' :: Eq a => [a] -> [[a]]



while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = [x | x <- takeWhile p $ iterate (f) x0]


syracuse :: Int -> [Int]
syracuse 0 = [1]
syracuse k = while (/= 1) step_func k ++ [1]
    where
        step_func k
            | odd k = 3 * k + 1
            | otherwise = div k 2 

-- TO DO
--loop :: Int -> (a -> a) -> a -> [a]
--loop 0 f x0 = []
--loop k f x0 = x0 : while (/= k-1) f x0


--
-- Exercice 3
--

-- xs ++ ys == foldr (:) xs ys
cycle' :: [a] -> [a]
cycle' xs = let ys = xs ++ ys in ys


isEquivalent :: Eq a => [a] -> [a] -> Bool
isEquivalent [] [] = True
isEquivalent (x : xs) (y : ys) = x == y && isEquivalent xs ys


-- TO DO with foldr or foldl
-- borders :: (Eq a) => [a] -> [[a]]
-- borders [] = [""]
-- borders (x : xs) = [x | x <- xs, p x]
--    where
--        p x = isEquivalent [x]  


-- to do
-- sublists :: Int -> [a] -> [[a]]
-- sublists 0 _ = [[]]
-- sublists k (x : xs) = [x | x <- xs ] ++ sublists (k - 1) xs


-- my function to delete this elem from (all occurences)
-- but if we need to delete only one we can actually
-- use flag to tell if we already deleted or not!
listWithoutElem :: Eq a => a -> [a] -> [a]
listWithoutElem _ [] = []
listWithoutElem elem (x : xs)
    | elem == x = listWithoutElem elem xs
    | otherwise = x : listWithoutElem elem xs



select :: Eq a => [a] -> [(a, [a])]
select xs = zipWith (,) xs [listWithoutElem x xs | x <- xs]



-- to do
-- partitions :: [a] -> [[[a]]]
-- partitions [] = [[]]
-- partitions xs


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x0, x1) (x2, x3) = (x2 <= x1 || x0 <= x3) && not ((x1 < x2) || (x3 < x0))


distance :: (Int, Int) -> Int
distance (x, y)
    | x > y = x - y
    | otherwise = y - x


unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI xs = let lst = [distance x | x <- xs] in all (== head lst) lst

--all (==firstDistance lstDistance xs) xs
--    where
--        lstDistance xs = 
--        firstDistance xs = head xs

isSortedInt :: [Int] -> Bool
isSortedInt [] = True
isSortedInt [x] = True
isSortedInt (x : y : xs)
    | x <= y = True && isSortedInt (y : xs)
    | otherwise = False && isSortedInt (y : xs)

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI xs = isSortedInt [fst x | x <- xs]


-- close to be done
--coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
--coverI (x1, x2) (x3, x4) =
--    if x1 <= x3 then
--        if x2 <= x4 then 
--            (x1, x4)
--        else
--            (x1, x2)
--    else if x2 > x4 then
--        (x1, x2)
--    else 
--        (x3, )


-- to do
-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]



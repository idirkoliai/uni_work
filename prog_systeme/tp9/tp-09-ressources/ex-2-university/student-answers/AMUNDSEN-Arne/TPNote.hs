import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n - 1], mod n x == 0]


perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (properFactors x) == x]


fizzBuzz :: [String]
fizzBuzz = [choice x | x <- [1..]]
    where
        choice y = if mod y 3 == 0
                   then if mod y 5 == 0
                        then "fizzbuzz"
                        else "fizz"
                   else if mod y 5 == 0
                        then "buzz"
                        else show y


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 a b = [(x, y, z) | x <- [a..b],
                              y <- [a..b],
                              z <- [a..b],
                              z < x,
                              (y /= x && y == z) || (y == x && y /= z)
                              ]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' f []      = False
any' f (x: []) = f x
any' f (x: xs) = if f x then True else any' f xs


-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = let n = f x0 in if p n
                               then x0 : while p f n
                               else [x0]


syracuse :: Int -> [Int]
syracuse n = while (/=1) (\x -> if mod x 2 == 0 then div x 2 else x * 3 + 1) n


loop :: Int -> (a -> a) -> a -> [a]
loop 1 f x0 = [x0]
loop k f x0 = x0 : loop (k - 1) f (f x0)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs


-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (xi1, xi1') (xi2, xi2') = let xs = [xi1..xi1'] ++ [xi2..xi2'] in not (nub xs == xs)

unitI :: [(Int, Int)] -> Bool
unitI []             = True
unitI ((i1, i2): is) = go (i2 - i1) is
    where
        go int []             = True
        go int ((i1, i2): is) = if (i2 - i1) /= int
                                then False
                                else go int is


isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI []            = True
isLeftSortedI ((i1, _): is) = go i1 is
    where
        go val [] = True
        go val ((i1, _): is) = if val <= i1
                               then go i1 is
                               else False


coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (i1, i1') (i2, i2') = (min i1 i2, max i1' i2')


-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
-- coversLeftSortedI (i: is) = go i is
--     where
--         go _ []          = []
--         go tempI (i: []) = [tempI]
--         go tempI (i: is@(i': is')) = if intersectI tempI i
--                                      then go (coverI tempI i) is
--                                      else tempI : coversLeftSortedI i' is'

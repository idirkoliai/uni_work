import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (properFactors x) == x]

fizzBuzz :: [String]
fizzBuzz = [f x | x <- [1..]]
    where
        f x
            | x `mod` 3 == 0 && x `mod` 5 == 0 = "fizzbuzz"
            | x `mod` 3 == 0 = "fizz"
            | x `mod` 5 == 0 = "buzz"
            | otherwise = show x

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN],
                        z < x,
                        y /= x || y /= z,
                        even x || even y || even z,
                        odd x || odd y || odd z]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs)
    | p x = True
    | otherwise = any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr g False
    where
        g x b = p x || b

group' :: Eq a => [a] -> [[a]]
group' [] = []
group' xss@(x:xs) = takeWhile (== x) xss : group' (dropWhile (== x) xs)

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = takeWhile p (iterate f x0)

syracuse :: Int -> [Int]
syracuse n = while (/= 1) (\x -> if even x then x `div` 2 else x*3+1) n ++ [1]

loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop k f x0 = x0 : loop (pred k) f (f x0)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = foldr (:) (cycle' xs) xs

-- borders :: (Eq a) => [a] -> [[a]]
-- borders [] = [[]]
-- borders [x] = [[], [x]]
-- borders xs = go (length xs)
--     where
--         go 0 = [[]]
--         go n
--             | take n xs == drop (length xs - n) xs = take n xs : go (pred n)
--             | otherwise = [[]]

-- sublists :: Int -> [a] -> [[a]]
-- sublists 0 _ = [[]]
-- sublists k xss@(x:xs)
--     | k > length xss = []
--     | k == length xss = [xss]
--     | otherwise = sublists k xs ++ [x:xs | xs <- sublists k xs]

select :: (Eq a) => [a] -> [(a, [a])]
select [] = []
select [x] = [(x, [])]
select xss@(x:xs) = take (length xss) ((x, delete x xss) : select (xs++[x]))

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x,y) (x',y') = y >= x' && x <= y'

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [x] = True
unitI (x:y:xs)
    | snd x - fst x /= snd y - fst y = False
    | otherwise = unitI xs

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [x] = True
isLeftSortedI (x:y:xs)
    | fst x > fst y = False
    | otherwise = isLeftSortedI (y:xs)

mini :: Int -> Int -> Int -> Int -> Int
mini a b c d
    | a < b && a < c && a < d = a
    | b < c && b < d = b
    | c < d = c
    | otherwise = d

maxi :: Int -> Int -> Int -> Int -> Int
maxi a b c d
    | a > b && a > c && a > d = a
    | b > c && b > d = b
    | c > d = c
    | otherwise = d

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (x,y) (x',y') = (mini x y x' y', maxi x y x' y')

coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [] = []
coversLeftSortedI [x] = [x]
coversLeftSortedI (x:y:xs)
    | intersectI x y = coversLeftSortedI (coverI x y : xs)
    | otherwise = x : coversLeftSortedI (y:xs)

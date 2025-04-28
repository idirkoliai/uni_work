import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..(n-1)], mod n x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], (sum $ properFactors x) == x]

fizzBuzzIntermediate :: Int -> String
fizzBuzzIntermediate n 
    | mod n 3  == 0 && mod n 5 == 0 = "fizzbuzz"
    | mod n 3 == 0 = "fizz"
    | mod n 5 == 0 = "buzz"
    | otherwise = show n

fizzBuzz :: [String]
fizzBuzz = [fizzBuzzIntermediate x | x <- [1..]]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 n k = [(x,y,z) | x <- [n..k], y <- [n..k], z <- [n..k],
                            z < x,
                            y /= x || y /= z,
                            ((even x && even y && even z) == False) && ((odd x && odd y && odd z) == False)
                            ]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs)
    | p x = True
    | otherwise = any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = length (foldr (\x acc -> if p x then x :acc else acc) [] xs) > 1

--group' :: Eq a => [a] -> [[a]]
--group' xs = foldr (\x y acc -> if x == y then x:y:acc else acc) [] xs

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x 
    | p x = x : while p f (f x)
    | otherwise = []

syracuse :: Int -> [Int]
syracuse x = while (/= 1) syracuse' x ++ [1]
    where
        syracuse' x 
            | even x = div x 2
            | otherwise = 3 * x + 1


loop :: Int -> (a -> a) -> a -> [a]
loop 0 _ _ = []
loop k f x = x : loop (k - 1) f (f x)

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' (x:xs) = x : cycle' (xs ++ [x]) 

{-
borders :: (Eq a) => [a] -> [[a]]
borders [] = [[]]
borders [x] = [[],[x]]
borders xs'@(x:xs)
    | x == (head (reverse xs')) = x ++ borders xs
    | otherwise = borders xs
-}

sublists :: Int -> [a] -> [[a]]
sublists 0 [] = [[]]
sublists _ [] = []
sublists k (x:xs)
    |k < 0 = []
    | otherwise = map (x:) (sublists (k-1) xs) ++ sublists k xs

select :: [a] -> [(a, [a])]
select [] = []
select [x] = [(x, [])]
select (x:xs) = (x, xs) : select xs

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI x y 
    | snd x >= fst y && fst x <= snd y = True
    | otherwise = False

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [x] = True
unitI (x:y:xs) = length [fst x.. snd x] == length [fst y..snd y] && unitI (y:xs)

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [x] = True
isLeftSortedI (x:y:xs) = fst x <= fst y && isLeftSortedI (y:xs)

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI x y = (min (fst x) (fst y), max (snd x) (snd y))

coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [] = []
coversLeftSortedI [x] = [x]
coversLeftSortedI (x:y:xs)  
    | intersectI x y = coversLeftSortedI (coverI x y:xs)
    | otherwise = x : coversLeftSortedI (y:xs)

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], n `mod` x >= 0]

--perfects :: Int -> [Int]
--perfects n = [x | x <- properFactors n]

--fizzBuzz :: [String]
--fizzBuzz = []

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | x <- [fromN..toN], y <- [fromN..toN], z <- [fromN..toN], z < x, y/=x || y/=z , (x `mod` 2 /= y `mod` 2) && (y `mod` 2 /= z `mod` 2)]

any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f (x: xs)
    | f x = True
    |otherwise = any' f xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' f = foldr(\x acc -> if f x then True else acc) False 

--group' :: (Eq a) => [a] -> [[a]]
--group' = foldr(\(x, y) acc -> if x == y then x: acc else [x] ++ acc) [[]]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while f p n 
    | f n = n : while f p (p n)
    | otherwise = []

syracuse :: Int -> [Int]
syracuse n = while (/=1) (\x -> if x `mod` 2 == 0 then x `div` 2 else (x * 3) + 1) n ++ [1]

--loop :: Int -> (a -> a) -> a -> [a]
--loop max f n = while (/= max) f n

cycle' :: [a] -> [a]
cycle' xs = cycle xs ++ xs

borders :: (Eq a) => [a] -> [[a]]
borders [] = [[]]
borders (x: xs) = [[x]] ++ [y | y <- borders xs]

sublists :: Int -> [a] -> [[a]]
sublists 0 _ = [[]]
sublists n (x: xs) =  [x] : sublists (n-1) xs

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (a, b) (c, d) = if c < b && d < a then False else True

--unitI :: [(Int, Int)] -> Bool
--unitI [] = True
--unitI [(_, _)] = True
--unitI ((a, b): xs) = b-a && unitI xs

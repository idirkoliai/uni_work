import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors x = filter (\i -> mod x i == 0) (takeWhile (<x) $ iterate (+1) 1)


perfects :: Int -> [Int]
perfects 1 = []
perfects x = filter(\i -> sum (properFactors i) == i) (take x $ iterate (+1) 1)

resFizzBuzz :: Int -> String
resFizzBuzz x = if mod x 3 == 0 then if mod x 5 == 0 then "fizzbuzz" else "fizz" else if mod x 5 == 0 then "buzz" else show x

fizzBuzz :: [String]
fizzBuzz = map (\x -> resFizzBuzz x) (iterate (+1) 1 )

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs) = if p x then True else any' p xs  

-- any'' :: (a -> Bool) -> [a] -> Bool
-- any'' p [] = False
-- any'' p (x:xs) = p x (||) (foldr p False xs)

-- group' :: Eq a => [a] -> [[a]]
-- group' [] = []
-- group' (x:[]) = [[x]]
-- group' (x:y:xs) = if x == y then [x] ++ ( foldr (\a b -> a == b) False (y:xs)) else [[x]] ++ ( foldr (\a b -> a == b) False (y:xs))

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = if p (f x0) then [x0] ++ while p f (f x0) else [x0]

syracuse :: Int -> [Int]
syracuse 1 = [1]
syracuse x 
    |mod x 2 == 0 = [x] ++ syracuse (div x 2)
    |otherwise = [x] ++ syracuse (x * 3 +1 )

loop :: Int -> (a -> a) -> a -> [a]
loop 1 f x0 = [x0]
loop k f x0 = [x0] ++ loop (k-1) f (f x0)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' x = x ++ cycle x

-- borders :: (Eq a) => [a] -> [[a]]
-- borders "" = [""]

-- sublists :: Int -> [a] -> [[a]]
-- sublists 0 x = [[]]
-- sublists k [] = []
-- sublists k (x:xs)
--     |k > length (x:xs) = [] 
--     |otherwise = [x] ++ sublists (k-1) xs

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x1,y1) (x2,y2) = if x1 < x2 then y1 > x2 else y2 > x1

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI (x:[]) = True
unitI ((x1,x2):(y1,y2):xs) = if x2-x1 == y2-y1 then unitI ((y1,y2):xs) else False 

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI (x:[]) = True
isLeftSortedI ((x1,x2):(y1,y2):xs) = if x1 > y1 then False else isLeftSortedI ((y1,y2):xs)

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI (x1,x2) (y1,y2) 
    | x1 < y1 = if x2 > y2 then (x1,x2) else (x1,y2)
    |otherwise = if x2 > y2 then (y1,x2) else (y1,y2)

coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [] = []
coversLeftSortedI (x:[]) = [x]
coversLeftSortedI ((x1,x2):(y1,y2):[]) = if intersectI (x1,x2) (y1,y2) then [(x1,y2)] else [(x1,x2), (y1,y2)]
coversLeftSortedI ((x1,x2):(y1,y2):xs) = if intersectI (x1,x2) (y1,y2) then coversLeftSortedI ((x1,y2):xs) else [(x1,x2)] ++ coversLeftSortedI ((y1,y2):xs)

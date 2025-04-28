import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], n `mod` x == 0]


perfects :: Int -> [Int]
perfects n = [x | x <-[1..n], sum (properFactors x) == x]


fizzBuzz :: [String]
fizzBuzz = [if x `mod` 15 == 0 then "fizzbuzz"   
    else if x `mod` 3 == 0 then "fizz"
    else if x `mod` 5 == 0 then "buzz"
    else show x | x <-[1..]]


-- altParity3 :: Int -> Int -> [(Int, Int, Int)]
-- altParity3 n = [ (x, y ,z) | x <- [0..n], y <- [0..n], z <- [0..n], 
--                even x, even y, odd z ]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs) = p x || any' p xs


any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr (\x acc -> p x || acc) False


group' :: Eq a => [a] -> [[a]]
group' = foldr (\x acc -> case acc of 
                    [] -> [[x]]         
                    (y:ys):zs -> if x == y then (x:y:ys):zs else [x]:(y:ys):zs) []


while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x = takeWhile p (iterate f x)


syracuse :: Int -> [Int]
syracuse n = while (/= 1) next n 
    where
     next x = if even x then x `div` 2 else 3 * x + 1


loop :: Int -> (a -> a) -> a -> [a]
loop k f x0 = take k (iterate f x0)

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs


borders :: (Eq a) => [a] -> [[a]]
borders xs =[ take n xs | n <- [0..length
 xs], take n xs == drop (length xs - n) 
 xs ]


--sublists :: Int -> [a] -> [[a]]
--sublists 0 _ = [[]]
--sublists _ [] = []
-- sublists k (x:xs)
--     k < 0      = [] 
--     otherwise = map (x:) (sublists (k-1) xs) ++ sublists k xs


select :: [a] -> [(a, [a])]
select []     = []
select (x:xs) = (x, xs) : [(y, x:ys) | (y, ys) <- select xs]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (x1, x2) (y1, y2) = x2 >= y1 && y2 >= x1


unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI ((x1, x2):xs) = all (\(y1, y2) -> (x2 - x1) == (y2 - y1)) xs


--isLeftSortedI :: [(Int, Int)] -> Bool
--isLeftSortedI [] = True
--isLeftSortedI [_] = True 
--isLeftSortedI ((x1, ):(x2, ):xs) = x1 <= 
-- x2 && isLeftSortedI ((x2, ):xs)


-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

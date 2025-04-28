import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <- [1..n-1], (n `mod` x) == 0]


perfects :: Int -> [Int]
perfects n = [ x | x <- [1..n-1], (sum (properFactors x) == x)]  

fizzBuzz :: [String]
fizzBuzz = [fizzBuzzInter x | x <- [1..]]

fizzBuzzInter :: Int -> String
fizzBuzzInter n
  | (n `mod` 3 == 0) && (n `mod` 5 == 0) = "fizzbuzz"
  | n `mod` 3 == 0 = "fizz"
  | n `mod` 5 == 0 = "buzz"
  | otherwise      = show n

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z) | x <- [fromN..toN],y <- [fromN..toN],z <- [fromN..toN], respectCondition x y z]

respectCondition :: Int -> Int -> Int -> Bool
respectCondition x y z = (z < x) && ( y /= x || y /= z) && ((even x && even y && even z) == False) && ((odd x && odd y && odd z) == False)

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs) = p x || any' p xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p xs = length (foldr (\x acc -> if p x then x :acc else acc) [] xs) > 1

--group' :: Eq a => [a] -> [[a]]
--group' xs'@(x:y:xs) = foldr (\x y acc -> if (x == y) then x ++ acc else acc) [] xs'

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = if p x0 then x0 : while p f (f x0) else []

syracuse :: Int -> [Int]
syracuse x = (while (/= 1) (\x -> if x `mod` 2 == 0 then x `div` 2 else (x * 3) + 1 ) x) ++ [1]

loop :: Int -> (a -> a) -> a -> [a]
loop p f x0
  | p == 0    = []
  | otherwise = x0 : loop (p-1) f (f x0) 


--
-- Exercice 3
--
cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

--borders :: (Eq a) => [a] -> [[a]]
--borders []     = [""] 
--borders [a]    = ["",a]
--borders (x:xs) = if 

sublists :: Int -> [a] -> [[a]]
sublits 0 [] = [[]]
sublits _ [] = []
sublists k (x:xs)
  | k < 0 = []
  | otherwise = map (x:) (sublists (k-1) xs) ++ sublists k xs

select :: [a] -> [(a, [a])]
select []      = []
select [a]     = [(a,[])]
select xs'@(x:y:xs)  = (x, xs) : select xs 

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

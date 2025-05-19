import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x<-[1..n-1], mod n x == 0]

perfects :: Int -> [Int]
perfects n = [x | x<-[1..n], x == sum (properFactors  x)]


fizzBuzz :: [String]
fizzBuzz = [fizzBuzzAux x | x <- [1..]]
    where 
        fizzBuzzAux x
            | mod x 5 == 0 && mod x 3 == 0 = "fizzbuzz"
            | mod x 5 == 0                 = "buzz"
            | mod x 3 == 0                 = "fizz"
            | otherwise                    = show x

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x, y, z) | x <- [fromN..toN], y <- [fromN..toN],  z <- [fromN..x-1], y /=x || y/=z, parDiff (x+y) (x+z) (y+z)] 
    where parDiff a b c = odd a || odd b || odd c 

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x : xs) = p x || any' p xs


any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr (\x res -> p x || res) False 


group' :: Eq a => [a] -> [[a]]
group' = foldr f [] 
    where 
        f n [] = [[n]]
        f n xss@(xs@(x: _): xss')
            | n == x              = (n : xs) : xss' 
            | otherwise           = (n : [] ) : xss


while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0
    | p x0      =   x0 : while p f (f x0)
    | otherwise = []

    


-- syracuse :: Int -> [Int]

loop :: Int -> (a -> a) -> a -> [a] 
loop k f x0
    | k > 0      =   x0 : loop (pred k) f (f x0)
    | otherwise = []

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = [x |  _ <- [1..], x <- xs ] 

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

-- select :: [a] -> [(a, [a])]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

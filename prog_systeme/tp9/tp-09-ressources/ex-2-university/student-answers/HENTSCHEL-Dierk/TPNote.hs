import           Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]

properFactors :: Int -> [Int]
properFactors n = [x' | x' <-[1..n] ,mod n x' == 0 && x'< n]




-- perfects :: Int -> [Int]

perfects :: Int -> [Int]
perfects n = [x' | x' <-[1..n] ,sum (properFactors x') == x']


-- fizzBuzz :: [String]

checknumber :: Int -> String
checknumber n 
    |(mod n 3 == 0) && (mod n 5 == 0 ) = "fizzbuzz"
    |mod n 3 == 0 = "fizz"
    |mod n 5 == 0 = "buzz"
    |otherwise = show n

fizzBuzz :: [String]
fizzBuzz = [checknumber n| n <- [1..]]
        
    

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 n b = [(x|x<-[n..b],y|y<-[n..b],z|z<-[n..b])]

--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool

-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

-- cycle' :: [a] -> [a]

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

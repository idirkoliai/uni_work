import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [x | x <-[1..n-1] , (mod)n x == 0 ]


perfects :: Int -> [Int]
perfects n = [x | x <-[1..n] , sum(properFactors x) == x  ]



fizzBuzz :: [String]
fizzBuzz = [if (mod) x  15 == 0 then "fizzbuzz" 
            else if (mod) x  3 == 0 then "fizz"
            else if (mod) x  5 == 0 then "buzz"
            else show x | x <-[1..] ]

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,z)| x<-[fromN..toN] , y<-[fromN..toN] , z<-[fromN..toN] , z < x , y/=x || y/= z && even x /= even y && even x /= even z  && even y /= even z ] 

   

--
-- Exercice 2
--


any' :: (a -> Bool) -> [a] -> Bool
any' p (x:xs) = if p x then True 
                else if p (tail xs) then True 
                else False 

foldr p = (/x acc -> p )

-- any'' :: (a -> Bool) -> [a] -> Bool

-- group' :: Eq a => [a] -> [[a]]

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0

-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs

borders :: (Eq a) => [a] -> [[a]]
borders [] = [[]]
borders [x] = [[],[x]]


sublists :: Int -> [a] -> [[a]]
sublists 0 xs = [[]]
sublist n xss  = head xss 

select :: [a] -> [(a, [a])]
select xs = [(x , xs') | x <-xs , xs'<-delete x xs  ]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

unitI :: [(Int, Int)] -> Bool
unitI [ ]= True
unitI [xss] = True 
unitI [xss] = True 


-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

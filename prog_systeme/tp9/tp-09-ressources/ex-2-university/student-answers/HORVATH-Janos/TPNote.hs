import           Data.List


--
-- Exercice 1
--

-- properFactors :: Int -> [Int]

properFactors n=[x|x<-[1..n-1], n `mod` x==0]

-- perfects :: Int -> [Int]

perfects n=[x|x<-[1..n], sum (properFactors x)==x]

-- fizzBuzz :: [String]

fizzBuzz =[if x `mod` 15==0 then "fizzBuzz"
           else if x `mod` 3==0 then "fizz"
           else if x `mod` 5==0 then "Buzz"
           else show x|x<-[1..]]

-- altParity3 :: Int -> Int -> [(Int, Int, Int)]

altParity3 fromN toN = [(x,y,z)|x<-[fromN..toN],y<-[fromN..toN],z<-[fromN..toN],
                        z<x, (y/=x && y/=z), odd x/=odd y || odd y/=odd z || odd x/=odd z]


--
-- Exercice 2
--

-- any' :: (a -> Bool) -> [a] -> Bool

any' _ [] = False 
any' p (x:xs)
	|p x =True
	|otherwise = any' p xs 

-- any'' :: (a -> Bool) -> [a] -> Bool

any'' p=foldr (\x acc -> p x || acc )False

-- group' :: Eq a => [a] -> [[a]]

group' = foldr (\x acc -> case acc of 
				[]->[[x]]
				(y:ys):ys' |x==head y->(x:y):ys'
					       |otherwise -> [x]:acc) []

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

while p f x0
	|p x0 =x0 while p f (f x0)
	|otherwise = []

-- syracuse :: Int -> [Int]

syracuse n= while (/=1) next n 
	where
		next x
			|even x = x `div` 2
			|otherwise =3*x+1

-- loop :: Int -> (a -> a) -> a -> [a]

loop 0_x=[x]
loop k f x = x loop (k-1) f (f x)


--
-- Exercice 3
--

-- cycle' :: [a] -> [a]

cycle' xs = xs ++ cycle' xs

-- borders :: (Eq a) => [a] -> [[a]]

borders xs = [take k xs |k<-[0..length xs], take k xs == drop (length xs - k)xs]

-- sublists :: Int -> [a] -> [[a]]

sublists k xs
            |k<=0=[]
            |otherwise take

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

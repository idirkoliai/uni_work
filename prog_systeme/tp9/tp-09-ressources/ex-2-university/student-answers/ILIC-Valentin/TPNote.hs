import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors n = [diviseur | diviseur <- [1..n-1],n `mod` diviseur == 0]

perfects :: Int -> [Int]
perfects n = [perfect | perfect<-[1..n],perfect == sum (properFactors n)]



--fizzBuzz :: [String]
--fizzBuzz = [val | val<- map f [1..] ]
--    where f x
--        |(x 'mod' 5 == 0) = "buzz"
--        |(x `mod` 3==0) = "fizz"
--        |otherwise = show x
    

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN = [(x,y,y)|x<-[fromN..toN],y<-[fromN..toN],z<-[fromN..toN],z<x, y/=x,y/=z,((even x && even y && even z) ==False) && ((odd x && odd y && odd z)==False)]


--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p []= False
any' p [x] = p x
any' (x:xs)
    |p x = True
    |otherwise = any' xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' p lst = foldr p False lst


group' :: Eq a => [a] -> [[a]]
group' lst = foldr (\x acc ->if head acc == x then x:acc else [x]) [] lst

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 = takeWhile (p) (map f [x0..])

syracuse :: Int -> [Int]
syracuse nb = while (\n -> n==1) (\x-> if x `mod` 2==0 then x/2 else (x*3)+1) nb

loop :: Int -> (a -> a) -> a -> ([a], Int)
loop 0 _ _ = []
loop k f x0 = let val = f x0 in val : loop (k-1) f val

--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = []
cycle' lst = concatMap (iterate id) lst

-- borders :: (Eq a) => [a] -> [[a]]

-- sublists :: Int -> [a] -> [[a]]

select :: [a] -> [(a, [a])]
select xs = [(x,delete x xs')|x<-xs]

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI i1 i2 = (length [val|val<-[fst i1..snd i1],val2<-[fst i2..snd i2],val == val2]) >= 1

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI (o:lst) = let l = (snd o - fst o) in length ([x| x<-(o:lst),(snd x - fst x) == l]) == length (o:lst)

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]


main :: IO()



import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors k = [x| x<-[1..k],  k `div` x /= (k-1 )`div` x, x /=k]


perfects :: Int -> [Int]
perfects k = [x| x<-[1..k], sum(properFactors x) == x]

--fizzBuzz :: [String]


altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 a b = [(x,y,z)| x<-[a..b], y<-[a..b] , z<-[a..b], z<x, (y/=x) || (y/=z)]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs)
    | (p x) = True
    | otherwise = any' p (xs)

any'' :: (a -> Bool) -> [a] -> Bool
any'' p = foldr (\x acc-> if p x then True else acc) False

group' :: Eq a => [a] -> [[a]]
group' [] = []
group' [x] = [[x]]
group' (x:xs) = [takeWhile(==x) xs] ++ group' (dropWhile(==x) xs)

--while :: (a -> Bool) -> (a -> a) -> a -> [a]
--while p f x0 = foldr (\x acc-> if p x then f x : acc else acc) []


-- syracuse :: Int -> [Int]

-- loop :: Int -> (a -> a) -> a -> [a], Int)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' x = take (length x) x ++ cycle' x

--borders :: (Eq a) => [a] -> [[a]]
--borders "" = [""]
--borders [x] = ["",x]
--borders (x:xs) = 




sub :: [a] -> [[a]]
sub [] = [[]]
sub (x:xs) = xss ++ map (x:) xss
    where xss = sub xs

sublists :: Int -> [a] -> [[a]]
sublists k = filter ((==) k.length).sub

select :: [a] -> [(a, [a])]
select [] = []
select [x] = [(x,[])]
select (x:xs) = [(x,xs)] ++ select xs

--partitions :: [a] -> [[[a]]]
--partitions [] = [[]]
--partitions [x] = [[[x]]]
--partitions (x:xs) = [[[x,xs]]] ++ partitions xs


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI x y = borneG && borneD
    where
        borneG = (snd x) > (fst y)
        borneD = (snd y) > (fst x)

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [x] = True
unitI (x:y:xs)
    | (snd x) - (fst x) == (snd y) - (fst y) = unitI(y:xs)
    | otherwise = False

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [x] = True
isLeftSortedI (x:y:xs)
    | (fst x) <= (fst y) = isLeftSortedI (y:xs)
    | otherwise = False

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
coverI x y = (first,end)
    where
        first 
            | fst(x) < fst(y) = fst(x)
            | otherwise = fst(y)
        end 
            | snd(x) < snd(y) = snd(y)
            | otherwise = snd(x)


-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

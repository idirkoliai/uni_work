import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors x = [z | z <- [1..x-1], x `mod`z==0]

perfects :: Int -> [Int]
perfects x = [ z | z <- [1..x],sum(properFactors z)==z]

--fizzBuzz :: [String]
--fizzBuzz = [f x | x <- ]
-- where
--  f  show x 
--   | x `mod` 3 == 0 && x `mod` 5 == 0 = "fizzbuzz"
--   | x `mod` 3 == 0 = "fizz"
--   | x `mod` 5 == 0 = "buzz"
--   | otherwise = show x
 
altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 fromN toN =  [(x,y,z)| x <-[fromN+1..toN], y <- reverse [fromN..toN], z <-  [fromN..y] , z <y ]

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' f (x:xs)
 | f x = True
 | otherwise = any' f xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' f = foldr test False
 where 
  test acc xs 
   | f acc = True
   | otherwise = xs

--group' :: Eq a => [a] -> [[a]]
--group' [] = [[]]
--group'  (x:xs)= foldr test [] xs
-- where 
--  test acc xs
--   | head == xs = acc ++[xs]
--   | otherwise = acc


while :: (a -> Bool) -> (a -> a) -> a -> [a]
while p f x0 =  takeWhile p (iterate f x0 )

syracuse :: Int -> [Int]
syracuse x = (while (/=1) f x) ++ [1]
 where
  f x 
   | even x = x `div`2
   | otherwise = x*3+1

loop :: Int -> (a -> a) -> a -> [a]
loop k f x0 = take k (iterate f x0)


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' xs = xs++cycle' xs

-- ne marche pas
--borders :: (Eq a) => [a] -> [[a]]
--borders [] = ["",[]]
--borders (x:xs) = takeWhile f xs ++ borders xs



-- ne marche pas
sublists :: Int -> [a] -> [[a]]
sublists _ [] = [[]]
sublists 0 _ = [[]]
sublists k (x:xs) =  [x: (take k ys) | ys <- sublists k (drop k xs)] ++ sublists k xs

select :: [a] -> [(a, [a])]
select [] = []
select xs =  test xs (length xs )
 where 
  test _ 0 = []
  test (x:xs) r = [(x,xs)]++test ((xs++[x])) (r-1)

--partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

-- intersectI :: (Int, Int) -> (Int, Int) -> Bool

-- unitI :: [(Int, Int)] -> Bool

-- isLeftSortedI :: [(Int, Int)] -> Bool

-- coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)

-- coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]

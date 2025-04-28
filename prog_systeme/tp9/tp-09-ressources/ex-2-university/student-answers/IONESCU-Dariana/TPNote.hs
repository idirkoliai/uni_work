import           Data.List


--
-- Exercice 1
--

properFactors :: Int -> [Int]
properFactors [] = []
properFactors x = 

sum :: Num a => [a] -> a
sum []
sum (x:xs) = x + sum xs

-- perfects :: Int -> [Int]
-- il faut que je parcours la liste des entiers jusqu'à x, en vérifiant pour chacun si sum(properFactors) == x
-- perfects x =   

fizzBuzz :: [String]
fizzBuzz s
    | s 'mod' 3 == 0 = "fizz"
    | s 'mod' 5 == 0 = "buzz"
    | s 'mod' 3 == 0 && s 'mod' 5 == 0 = "fizzbuzz"
    | otherwise = ""

altParity3 :: Int -> Int -> [(Int, Int, Int)]
altParity3 _ = []
-- altParity3 x y = if even x then

--
-- Exercice 2
--

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = error "any' : empty list"
any' p (x:xs) = if p x = any' p xs then True else False

any'' :: (a -> Bool) -> [a] -> Bool
any'' _ [] = error "any'' : empty list"
-- any'' p xs = foldr

takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile _ [] = []
takeWhile p (x:xs)
    | p x = x : takeWhile p xs
    | otherwise = []

group' :: Eq a => [a] -> [[a]]
group' [] = []
group' [x] = [[x]]
group' xs = xs : f []
    where
        f = takeWhile(/=xs).tail

-- while :: (a -> Bool) -> (a -> a) -> a -> [a]

-- a réécrire avec la fonction while : 
syracuse :: Int -> [Int]
syracuse x 
    | x <= 0 = error "syracuse : negative or null number"  
    | even x && x != 1 = x / 2
    | odd x && x != 1 = x*3 + 1
    | otherwise = x : syracuse x

loop :: Int -> (a -> a) -> a -> [a]
loop x f elem = x : loop(f x)   -- ?


--
-- Exercice 3
--

cycle' :: [a] -> [a]
cycle' [] = error "cycle' : empty list"
cycle' xs = xs ++ cycle' xs

-- borders :: (Eq a) => [a] -> [[a]]
-- borders "" = [""]


-- sublists :: Int -> [a] -> [[a]]

select :: [a] -> [(a, [a])]
select [] = []
select [x] = [(x, [])]
select xs = 

-- partitions :: [a] -> [[[a]]]


--
-- Exercice 4
--

intersectI :: (Int, Int) -> (Int, Int) -> Bool
intersectI (w, x) (y, z) = if x <= y && x => z then True else False

unitI :: [(Int, Int)] -> Bool
unitI [] = True
unitI [(x,y)] = True
-- (a,b)...(y,z); True si b-a = ... = z-y, False sinon :
unitI (x:xs)

isLeftSortedI :: [(Int, Int)] -> Bool
isLeftSortedI [] = True
isLeftSortedI [(x,y)] = True
isLeftSortedI 

coverI :: (Int, Int) -> (Int, Int) -> (Int, Int)
-- trouver le minimum et le maximum dans tous les tuples réunis pour en faire l'intervalle :
-- ajouter chaque élément à une liste :
coverI x y = x : xy
coverI xs = (minimum xs, maximum xs)    -- à revoir


coversLeftSortedI :: [(Int, Int)] -> [(Int, Int)]
coversLeftSortedI [(x,y)] = [(x,y)]

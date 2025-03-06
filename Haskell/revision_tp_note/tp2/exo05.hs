import Data.List

msplit :: [a] -> ([a], [a])
msplit xs = (ev, od)
  where
    od = [xs !! i | i <- [0 .. length xs - 1], odd i]
    ev = [xs !! i | i <- [0 .. length xs - 1], even i]

merge :: (Ord a) => [a] -> [a] -> [a]
merge xs [] = xs 
merge [] xs = xs 
merge xs@(x:xs') ys@(y:ys') 
    | x > y = y : merge xs ys'
    | otherwise = x : merge xs' ys

mergeSort :: (Ord a) => [a] -> [a]
mergeSort [x] = [x]
mergeSort xs = merge (mergeSort ev) (mergeSort od) 
    where 
        (ev, od) = msplit xs

msplit2 :: (Ord a) => [a] -> ([a], [a])
msplit2 [] = ([], [])
msplit2 (x:xs) = (inf, sup)
  where
    inf = [x' | x' <- xs, x' <= x]  
    sup = [x' | x' <- xs, x' > x]   

quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort [x] = [x]
quickSort (x:xs) = quickSort inf ++ [x] ++ quickSort sup
  where 
    (inf, sup) = msplit2 (x:xs)   

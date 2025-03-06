import Data.List
isArithSerie :: (Eq a, Num a) => [a] -> Bool
isArithSerie ys@(x:xs@(y:z:xs'))  
    |length xs < 3 = True
    |otherwise = x-y == y-z && isArithSerie xs

isConstant :: Eq a => [a] -> Bool 
isConstant [] = True
isConstant [_] = True 
isConstant ys@(x:xs@(y:xs')) = x == y && isConstant xs

isArithSerie2 :: (Eq a, Num a) => [a] -> Bool
isArithSerie2 xs = isConstant [x-y | (x,y) <- zip xs $ tail xs]


mkArithSerie :: (Eq a, Num a) => a -> a -> a -> [a]
mkArithSerie _ _ 0 = [] 
mkArithSerie u r n = u : mkArithSerie (u + r) r (n-1)




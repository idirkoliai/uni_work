myAverage :: Float -> Float -> Float -> Float
myAverage x y z  = (x + y + z) / 3

myMin3 :: Int -> Int -> Int -> Int
myMin3 x y z 
    | x <= y && x <= z = x
    | y <= z = y
    | otherwise = z

myAdd :: Int -> Int -> Int 
myAdd 0 y = y
myAdd x 0 = x
myAdd x y = succ x `myAdd` pred y

myMult :: Int -> Int -> Int 
myMult _ 0 = 0
myMult 0 _ = 0
myMult x y = x `myAdd` (x `myMult` pred y)

myFact :: Int -> Int
myFact 0 = 1
myFact x = x `myMult` myFact (pred x)


myGCDEuclid :: Int -> Int -> Int
myGCDEuclid x y 
    | x == y = x
    | x < y = myGCDEuclid y x
    | otherwise = myGCDEuclid (x-y) y

myGCDEuclid2 :: Int -> Int -> Int
myGCDEuclid2 x y 
    | x < y = myGCDEuclid2 y x
    | y == 0 = x
    | otherwise = myGCDEuclid2 y (x `mod` y)


myAverage2 :: Int -> Int -> Int -> Float
myAverage2 x y z = fromIntegral(x+y+z) / 3


detectZero :: (Int -> Int) -> Int -> Int
detectZero f x 
    | f x == 0 = x
    | otherwise = detectZero f (succ x)
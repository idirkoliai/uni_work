any' :: (a -> Bool) -> [a] -> Bool
any' f (x:xs) 
    |length xs == 0 = False
    |f x = True
    |otherwise = any' f xs

while :: (a -> Bool) -> (a -> a) -> a -> [a]
while f g n 
    |f n = n : while f g (g n)
    | otherwise =  [] 

syracuse :: Int -> [Int]
syracuse n 
    | even n = while even (`div`2) n
    | otherwise = while odd ((+1).(* 3)) n

loop :: Int -> (a -> a) -> a -> [a]
loop n f x
    |n == 0 = []
    |otherwise = x : loop (n-1) f (f x)

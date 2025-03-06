head1 :: [a] -> a
head1 xs@(x:xs') = x

tail1 :: [a] -> [a]
tail1 xs@(x:xs') = xs'

last1 :: [a] -> a
last1 [x] = x
last1 xs@(x:xs') = last1 xs'


interval :: Int -> [Int]
interval 0 = []
interval num = go 1
    where 
        go n 
            | n > num = []
            | otherwise = n : go (succ n)

interval2 :: Int -> Int -> [Int]
interval2 x y = go x 
    where 
        go n
            | x > y || n > y = []
            | otherwise = n : go(succ n)


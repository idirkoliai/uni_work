cycle' :: [a] -> [a]
cycle' xs = xs ++ cycle' xs


sublists :: Int -> [a] -> [[a]]
sublists 1 xs =  [take 1 xss :  sublists 1 (drop 1 xss)]
sublists n xs = [take n xss :  sublists n (drop n xss)]
    where 

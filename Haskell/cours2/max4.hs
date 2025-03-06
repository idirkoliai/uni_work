max4 :: Int -> Int -> Int -> Int -> Int
max4 a b c d
    | a >= b && a >= c && a >= d = a
    | b >= c && b >= d           = b
    | c >= d                     = c
    | otherwise                  = d


-- max(a,max(b,max(c,d)))
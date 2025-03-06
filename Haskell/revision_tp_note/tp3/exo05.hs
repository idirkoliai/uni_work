-- (a) Génération de tous les triplets d'éléments distincts compris entre lb et lb+8

gen3 :: Int -> [(Int, Int, Int)]
gen3 lb = [(x1, x2, x3) | x1 <- range, x2 <- range, x3 <- range, x1 /= x2, x1 /= x3, x2 /= x3]
  where range = [lb..lb+8]

-- (b) Génération de tous les triplets d'éléments distincts compris entre lb et lb+8 qui ne sont pas dans xs

gen3' :: Int -> [Int] -> [(Int, Int, Int)]
gen3' lb xs = [(x1, x2, x3) | x1 <- filteredRange, x2 <- filteredRange, x3 <- filteredRange, x1 /= x2, x1 /= x3, x2 /= x3]
  where filteredRange = [x | x <- [lb..lb+8], x `notElem` xs]

-- (c) Génération de tous les carrés magiques d'ordre 3

magicSquare3 :: Int -> [((Int, Int, Int), (Int, Int, Int), (Int, Int, Int))]
magicSquare3 lb = [((a,b,c), (d,e,f), (g,h,i)) |
    (a,b,c) <- gen3 lb, (d,e,f) <- gen3 lb, (g,h,i) <- gen3 lb,
    let allNumbers = [a,b,c,d,e,f,g,h,i],
    length allNumbers == length (filter (`elem` allNumbers) [lb..lb+8]),
    sum [a,b,c] == sum [d,e,f],
    sum [d,e,f] == sum [g,h,i],
    sum [a,d,g] == sum [b,e,h],
    sum [b,e,h] == sum [c,f,i],
    sum [a,e,i] == sum [c,e,g]]

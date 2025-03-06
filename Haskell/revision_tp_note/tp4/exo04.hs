unshuffle :: [a] -> ([a], [a])
unshuffle xs = (odds, evens)
  where
    odds = [xs !! i | i <- [0 .. length xs - 1], odd i]
    evens = [xs !! i | i <- [0 .. length xs - 1], even i]

algoA :: [a] -> [a]
algoA xs = odds ++ evens
  where
    (odds, evens) = unshuffle xs

encode :: [a] -> Int -> [a]
encode xs 0 = xs
encode xs k = algoA $ encode xs (k - 1)

shuffle :: [a] -> [a] -> [a]
shuffle [] ys = ys
shuffle xs [] = xs
shuffle (x : xs) (y : ys) = x : y : shuffle xs ys

revAlgoA :: [a] -> [a]
revAlgoA xs = shuffle evens odds
  where
    (odds, evens) = splitAt (length xs `div` 2) xs

decode :: [a] -> Int -> [a]
decode xs 0 = xs
decode xs k = decode (revAlgoA xs) (k - 1)

easyCrack :: (Eq a) => [a] -> [[a]]
easyCrack xs = xs : f xss
  where
    xss = iterate (flip encode 1) xs
    f = takeWhile (/= xs) . tail
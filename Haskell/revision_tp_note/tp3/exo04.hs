unfold :: (a -> Bool) -> (a -> b) -> (a -> a) -> a -> [b]
unfold p h t x
  | p x = []
  | otherwise = h x : unfold p h t (t x)

lst0_9 :: [Integer]
lst0_9 = unfold (> 9) id (+ 1) 0

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x : xs) = head (unfold (const False) f id x) : map' f xs

map'' :: (a -> b) -> [a] -> [b]
map'' f = unfold null (f . head) tail

iterate' :: (a -> a) -> a -> [a]
iterate'  = unfold (const False) id 

altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
altMap f g xs = [func i | i <- [0 .. length xs - 1]]
  where
    func n
      | even n = f $ xs !! n
      | otherwise = g $ xs !! n

altMap' :: (a -> b) -> (a -> b) -> [a] -> [b]
altMap' _ _ [] = []
altMap' f g (x : xs) = f x : altMap' g f xs

altMap'' :: (a -> b) -> (a -> b) -> [a] -> [b]
altMap'' f g = snd . foldr (\x (flag, acc) -> if flag then (not flag, f x : acc) else (not flag, g x : acc)) (True, [])

digits :: (Integral a) => a -> [a]
digits 0 = []
digits n = digits (n `div` 10) ++ [n `mod` 10]

digits' :: (Integral a) => a -> [a]
digits' = reverse . unfold (== 0) (`mod` 10) (`div` 10)

luhn :: (Integral a) => [a] -> Bool
luhn xs = (== 0)  (mod (sum sumedDigi) 10)
  where
    sumedDigi = [sum $ digits $ xs' !! i | i <- [0 .. length xs' - 1], odd i] ++ [ xs' !! i | i <- [0 .. length xs' - 1],even i]
    xs' = altMap id (* 2) $ reverse xs
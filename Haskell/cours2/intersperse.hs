intersperse :: a -> [a] -> [a]
intersperse _ [x] = [x]
intersperse spliter (x:xs) = x : spliter : intersperse spliter xs 


intercalate :: [a] -> [[a]] -> [a]
intercalate _ [] = []
intercalate _ [x] = x
intercalate spliter (xs:xss) = xs ++ spliter ++ intercalate spliter xss
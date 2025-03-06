f :: [Char] -> [Char]
f = ("A" ++)
g :: [Char] -> [Char]
g = (++ "Z")
h :: [Char] -> [Char]
h = \x -> f (g x)
i :: [Char] -> [Char]
i = \x -> g (f x)
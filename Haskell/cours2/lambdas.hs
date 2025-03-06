g :: Integer -> Integer
g = \x -> x * x

h :: Integer -> Integer
h = \x -> g (g x)

i :: Integer -> Integer
i = \x -> h (h x)

j :: Integer -> Integer
j = \x -> i (i x)
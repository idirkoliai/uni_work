import Data.Char

hasSpace :: String -> Bool
hasSpace [] = False
hasSpace (x : xs) = isSpace x || hasSpace xs
        

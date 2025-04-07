-- natural integers
type Nat = Int

-- leaf labeled tree
data Tree a = Leaf a | Node Nat (Tree a) (Tree a) deriving Show

-- presence/absence of a complete binary tree
data Digit a = Zero | One (Tree a) deriving Show

-- Random access list
newtype RAList a = RAList { getDigits :: [Digit a] }

-- RAList "ABCDE"
mkRA_ABCDE :: RAList Char
mkRA_ABCDE = RAList { getDigits = [ One (Leaf 'A')
                                  , Zero
                                  , One (Node 4 (Node 2 (Leaf 'B') (Leaf 'C'))
                                   (Node 2 (Leaf 'D') (Leaf 'E')))
                                  ] }

-- RAList "ABCDEF"
mkRA_ABCDEF :: RAList Char
mkRA_ABCDEF = RAList { getDigits = [ Zero
                                   , One (Node 2 (Leaf 'A') (Leaf 'B'))
                                   , One (Node 4 (Node 2 (Leaf 'C') (Leaf 'D'))
                                                 (Node 2 (Leaf 'E') (Leaf 'F')))
                                   ] }

-- access by index
fetch :: Int -> [a] -> a
fetch _ []       = error "index too large"
fetch 0 (x :_)   = x
fetch k (_ : xs) = fetch (k-1) xs

-- the number of leaves in the binary tree.
sizeT :: Tree a -> Nat
sizeT (Leaf _)     = 1
sizeT (Node s _ _) = s

-- smart constructor
mkNodeT :: Tree a -> Tree a -> Tree a
mkNodeT t1 t2 = Node (sizeT t1 + sizeT t2) t1 t2

nilRA :: RAList a 
nilRA = RAList { getDigits = [] }

nullRA :: RAList a -> Bool
nullRA (RAList { getDigits = [] }) = True
nullRA _ = False

isZero :: Digit a -> Bool
isZero Zero = True
isZero _    = False

fromOne :: Digit a -> Tree a
fromOne (One t) = t


sizeRA :: RAList a -> Nat
sizeRA (RAList { getDigits = [] }) = 0
sizeRA (RAList { getDigits = (x:xs) }) 
    |  isZero x = sizeRA (RAList { getDigits = xs })
    | otherwise = (sizeT $ fromOne x) + sizeRA (RAList { getDigits = xs })
   

fromT :: Tree a -> [a]
fromT (Leaf x)     = [x]
fromT (Node _ t1 t2) = fromT t1 ++ fromT t2

fromRA :: RAList a -> [a]
fromRA (RAList { getDigits = [] }) = []
fromRA ralst@(RAList (x:xs) )
    | isZero x = fromRA (RAList xs)
    | otherwise = (fromT $ fromOne x) ++ fromRA (RAList xs)

headRA' :: RAList a -> Maybe a
headRA' ralst 
    | nullRA ralst = Nothing
    |otherwise = Just $ head $ fromRA ralst


--instance Show a => Show (RAList a) where
--  show (RAList ds) = "RA{" ++ show (concatMap fronTD ds) ++ "}"
--    where
--      fronTD Zero    = []
--      fronTD (One t) = fromT t

instance Show a => Show (RAList a) where
  show (RAList ds) = "RA{" ++ show (map fromTD ds) ++ "}"
    where
      fromTD Zero = []
      fromTD (One t) = concatMap (:[]) (fromT t)

consRA :: a -> RAList a -> RAList a
consRA x (RAList raList) =  RAList (consT (Leaf x) raList )
    where 
        consT t [] = [One t]
        consT t (Zero:ds) = One t : ds 
        consT t (One t': ds) = Zero : consT (mkNodeT t t') ds

toRA :: [a] -> RAList a
toRA = foldr consRA nilRA





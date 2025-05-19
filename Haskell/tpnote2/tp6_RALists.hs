import Distribution.Simple (KnownExtension (Rank2Types))
import Distribution.Simple.Utils (xargs)

-- natural integers
type Nat = Int

-- leaf labeled tree
data Tree a = Leaf a | Node Nat (Tree a) (Tree a) deriving (Show)

-- presence/absence of a complete binary tree
data Digit a = Zero | One (Tree a) deriving (Show)

-- Random access list
newtype RAList a = RAList {getDigits :: [Digit a]}

-- RAList "ABCDE"
mkRA_ABCDE :: RAList Char
mkRA_ABCDE =
  RAList
    { getDigits =
        [ One (Leaf 'A'),
          Zero,
          One
            ( Node
                4
                (Node 2 (Leaf 'B') (Leaf 'C'))
                (Node 2 (Leaf 'D') (Leaf 'E'))
            )
        ]
    }

-- RAList "ABCDEF"
mkRA_ABCDEF :: RAList Char
mkRA_ABCDEF =
  RAList
    { getDigits =
        [ Zero,
          One (Node 2 (Leaf 'A') (Leaf 'B')),
          One
            ( Node
                4
                (Node 2 (Leaf 'C') (Leaf 'D'))
                (Node 2 (Leaf 'E') (Leaf 'F'))
            )
        ]
    }

-- access by index
fetch :: Int -> [a] -> a
fetch _ [] = error "index too large"
fetch 0 (x : _) = x
fetch k (_ : xs) = fetch (k - 1) xs

-- the number of leaves in the binary tree.
sizeT :: Tree a -> Nat
sizeT (Leaf _) = 1
sizeT (Node s _ _) = s

-- smart constructor
mkNodeT :: Tree a -> Tree a -> Tree a
mkNodeT t1 t2 = Node (sizeT t1 + sizeT t2) t1 t2

nilRA :: RAList a
nilRA = RAList {getDigits = []}

nullRA :: RAList a -> Bool
nullRA ra = null $ getDigits ra

sizeRA :: RAList a -> Nat
sizeRA RAList {getDigits = ra} = lenRA ra
  where
    lenRA [] = 0
    lenRA (Zero : xs) = lenRA xs
    lenRA (One t : xs) = sizeT t + lenRA xs

fromT :: Tree a -> [a]
fromT (Leaf l) = [l]
fromT (Node _ lt rt) = fromT lt ++ fromT rt

fromRA :: RAList a -> [a]
fromRA ra
  | nullRA ra = []
  | otherwise = mapTrees $ getDigits ra
  where
    mapTrees [] = []
    mapTrees (Zero : xs) = mapTrees xs
    mapTrees (One t : xs) = fromT t ++ mapTrees xs

instance (Show a) => Show (RAList a) where
  show (RAList ds) = "RA{" ++ show (map fromTD ds) ++ "}"
    where
      fromTD Zero = []
      fromTD (One t) = concatMap (: []) (fromT t)

headRA' :: RAList a -> Maybe a
headRA' ra
  | nullRA ra = Nothing
  | otherwise = Just $ (head . fromRA) ra

consT :: Tree a -> [Digit a] -> [Digit a]
consT t [] = [One t]
consT t (Zero : xs) = One t : xs
consT t (One t' : xs) = Zero : consT (mkNodeT t t') xs

consRA :: a -> RAList a -> RAList a
consRA elem RAList {getDigits = ra} = RAList {getDigits = consT t ra}
  where
    t = Leaf elem

unconsT :: [Digit a] -> (Tree a, [Digit a])
unconsT [] = error "RAList is empty"
unconsT (Zero : ds) =
  let (t, ds') = unconsT ds
   in (t, Zero : ds')
unconsT (One t : ds) =
  case t of
    Leaf _ -> (t, Zero : ds)
    Node _ l r -> (l, consT r (Zero : ds))

unconsRA :: RAList a -> Maybe (a, RAList a)
unconsRA (RAList ds) =
  case dropWhile isZero ds of
    [] -> Nothing
    _ ->
      let (t, ds') = unconsT ds
       in case t of
            Leaf x -> Just (x, RAList ds')
            Node _ l r ->
              let (Leaf x, _) = unconsT [One l] -- car l est aussi un arbre
               in Just (x, RAList (consT r ds'))
  where
    isZero Zero = True
    isZero _ = False

type Nat = Int
newtype SymList a = SymList ([a], [a])
instance Show a => Show (SymList a) where
    show = show . fromSL


instance Eq a => Eq (SymList a) where
    xs == ys = fromSL xs == fromSL ys

instance Ord a => Ord (SymList a) where
    xs `compare` ys = fromSL xs `compare` fromSL ys

instance Functor SymList where
    fmap f (SymList (xs, ys)) = SymList (fmap f xs, fmap f ys)

-- Empty symmetric list
nilSL :: SymList a
nilSL = SymList ([], [])

-- Test empty symmetric list
nullSL :: SymList a -> Bool
nullSL (SymList ([], [])) = True
nullSL _ = False

-- Abstraction
fromSL :: SymList a -> [a]
fromSL (SymList (xs, ys)) = xs ++ reverse ys

-- Test invariant 1
testInv1 :: SymList a -> Bool
testInv1 (SymList ([], ys)) = length ys <= 1
testInv1 _ = True

-- Test invariant 2
testInv2 :: SymList a -> Bool
testInv2 (SymList (xs, [])) = length xs <= 1
testInv2 _ = True

-- Test invariant 1 && invariant 2
testInvs :: SymList a -> Bool
testInvs sl = testInv1 sl && testInv2 sl

singleSL :: SymList a -> Bool
singleSL (SymList ([], [x])) = True
singleSL (SymList ([x], [])) = True
singleSL _ = False

lengthSL :: SymList a -> Nat
lengthSL (SymList (xs, ys)) = length xs + length ys

consSL :: a -> SymList a -> SymList a
consSL x (SymList ([], xs)) = SymList ([x], xs)
consSL x (SymList (xs, [])) = SymList (xs, [x]) 
consSL x (SymList (xs, ys)) = SymList (x:xs, ys)

snocSL :: a -> SymList a -> SymList a
snocSL x (SymList ([], xs)) = SymList (xs, [x])
snocSL x (SymList (xs, [])) = SymList (xs, [x])
snocSL x (SymList (xs, ys)) = SymList (xs, x:ys)

toSL :: [a] -> SymList a
toSL [] = nilSL
toSL (x:xs) = SymList ([x], reverse xs)

headSL :: SymList a -> Maybe a
headSL (SymList ([], [])) = Nothing
headSL (SymList ([], [y])) = Just y
headSL (SymList (x:_,_)) = Just x 


lastSL :: SymList a -> Maybe a
lastSL (SymList ([], [])) = Nothing
lastSL (SymList ([x], [])) = Just x
lastSL (SymList (_, y:_)) = Just y


tailSL :: SymList a -> Maybe (SymList a)
tailSL (SymList ([], [])) = Nothing
tailSL (SymList ([], _)) = Just nilSL
tailSL (SymList (x:xs, ys)) = Just (SymList (xs, ys))


initSL :: SymList a -> Maybe (SymList a)
initSL (SymList ([], [])) = Nothing
initSL (SymList ([], _)) = Just nilSL
initSL (SymList (xs, y:ys)) = Just (SymList (xs, ys))
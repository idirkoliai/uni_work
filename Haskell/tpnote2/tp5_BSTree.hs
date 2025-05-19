import Control.Applicative (Alternative (empty))
import Control.Arrow (ArrowChoice (left, right))
import Data.IntMap (insert)
import Data.List qualified as L
import Distribution.Simple.Setup (falseArg)
import GHC.ForeignPtr (Finalizers (NoFinalizers))
import Data.Maybe (fromJust)
import System.Posix (fileAccess)
import Data.ByteString (sort)

data BSTree a = Node (BSTree a) a (BSTree a) | Empty
  deriving (Eq, Ord)

branchChar :: Char
branchChar = '-'

splitChar :: Char
splitChar = '+'

branchIndent :: Int
branchIndent = 5

branchNil :: Char
branchNil = '⊥'

instance (Show a) => Show (BSTree a) where
  show = showBSTree 0
    where
      drawBranch 0 = ""
      drawBranch n = L.replicate (n - branchIndent) branchChar ++ [splitChar] ++ L.replicate (branchIndent - 1) branchChar

      showBSTree n Empty = drawBranch n ++ branchNil : "\n"
      showBSTree n (Node lt x rt) =
        showBSTree (n + branchIndent) rt
          ++ drawBranch n
          ++ show x
          ++ "\n"
          ++ showBSTree (n + branchIndent) lt

mkExampleBSTree :: BSTree Integer
mkExampleBSTree = Node (Node (Node (Node Empty 1 Empty) 2 (Node Empty 3 Empty)) 4 (Node Empty 5 Empty)) 6 (Node (Node Empty 7 Empty) 8 (Node Empty 9 Empty))

countNodesBSTree :: (Num b) => BSTree a -> b
countNodesBSTree Empty = 0
countNodesBSTree (Node lt _ rt) = 1 + countNodesBSTree lt + countNodesBSTree rt

countLeavesBSTree :: (Num b) => BSTree a -> b
countLeavesBSTree Empty = 0
countLeavesBSTree (Node Empty _ Empty) = 1
countLeavesBSTree (Node lt _ rt) = countLeavesBSTree lt + countLeavesBSTree rt

heightBSTree :: (Num b, Ord b) => BSTree a -> b
heightBSTree Empty = 0
heightBSTree (Node lt _ rt) = 1 + max (heightBSTree lt) (heightBSTree rt)

leavesBSTree :: BSTree a -> [a]
leavesBSTree (Node Empty v Empty) = [v]
leavesBSTree (Node lt _ rt) = leavesBSTree lt ++ leavesBSTree rt

elemBSTree :: (Ord a) => a -> BSTree a -> Bool
elemBSTree e Empty = False
elemBSTree e (Node lt v rt)
  | v == e = True
  | e < v = elemBSTree e lt
  | otherwise = elemBSTree e rt

inOrderVisitBSTree :: BSTree a -> [a]
inOrderVisitBSTree Empty = []
inOrderVisitBSTree (Node lt v rt) = inOrderVisitBSTree lt ++ [v] ++ inOrderVisitBSTree rt

preOrderVisitBSTree :: BSTree a -> [a]
preOrderVisitBSTree Empty = []
preOrderVisitBSTree (Node lt v rt) = v : (preOrderVisitBSTree lt ++ preOrderVisitBSTree rt)

postOrderVisitBSTree :: BSTree a -> [a]
postOrderVisitBSTree Empty = []
postOrderVisitBSTree (Node lt v rt) = postOrderVisitBSTree lt ++ postOrderVisitBSTree rt ++ [v]

insertBSTree :: (Ord a) => BSTree a -> a -> BSTree a
insertBSTree Empty e = Node Empty e Empty
insertBSTree (Node lt v rt) e
  | e <= v = Node (insertBSTree lt e) v rt
  | otherwise = Node lt v (insertBSTree rt e)

fromListBSTree :: (Ord a) => [a] -> BSTree a
fromListBSTree = foldl insertBSTree Empty

toListBSTree :: BSTree a -> [a]
toListBSTree = preOrderVisitBSTree


mergeBSTree :: Ord a => BSTree a -> BSTree a -> BSTree a
mergeBSTree b1 b2 = foldl insertBSTree b1 $ toListBSTree b2


rightmostBSTree :: BSTree a -> Maybe a
rightmostBSTree Empty = Nothing
rightmostBSTree(Node _ v Empty) = Just v
rightmostBSTree (Node _ v rt) = rightmostBSTree rt


maxBSTree :: BSTree a -> Maybe a
maxBSTree = rightmostBSTree


deleteRootBSTree :: Ord a => BSTree a -> BSTree a
deleteRootBSTree Empty = Empty
deleteRootBSTree (Node Empty _ Empty) = Empty
deleteRootBSTree bst@(Node lt _ rt) =  Node (deleteBSTree newRoot lt) newRoot rt 
  where 
    newRoot = fromJust $ maxBSTree lt    


deleteBSTree :: Ord a => a -> BSTree a -> BSTree a
deleteBSTree e Empty = Empty
deleteBSTree e bst@(Node lt v rt) 
  | v == e = deleteRootBSTree bst
  | e > v  = Node lt v $ deleteBSTree e rt
  | otherwise = Node (deleteBSTree e lt) v rt  

mapBSTree :: (a -> b) -> BSTree a -> BSTree b
mapBSTree f Empty = Empty
mapBSTree f (Node lt v rt) = Node (mapBSTree f lt) (f v) (mapBSTree f lt) 

filterBSTree :: Ord a => (a -> Bool) -> BSTree a -> BSTree a
filterBSTree f Empty = Empty
filterBSTree f bst@(Node lt v rt) 
  | f v = Node (filterBSTree f lt) v (filterBSTree f rt)
  | otherwise = filterBSTree f $ deleteRootBSTree bst


foldBSTree :: (a -> b -> b) -> b -> BSTree a -> b
foldBSTree _ acc Empty = acc
foldBSTree f acc (Node lt x rt) = foldBSTree f acc'' lt
  where
    acc' = foldBSTree f acc rt
    acc'' = f x acc'

countNodesBSTree' :: BSTree a -> Integer
countNodesBSTree' = foldBSTree (\ _ acc  -> succ acc) 0

toListBSTree' :: BSTree a -> [a]
toListBSTree' = foldBSTree (:) [] 

genBSTrees :: (Num a, Enum a, Ord a) => a -> [BSTree a]
genBSTrees n = [fromListBSTree xs | xs <- L.permutations [1..n] ]

isBSTree ::Ord a => BSTree a -> Bool
isBSTree Empty = True
isBSTree (Node lt r rt) = isBSTree lt && isBSTree rt && greater r lt && lesser r rt 
  where 
    greater r Empty = True
    greater r (Node lt' v rt') = r >= v && greater r lt' && greater r rt'
    lesser r Empty = True
    lesser r (Node lt' v rt') = r < v && lesser r lt' && lesser r rt'

isBSTree' ::Ord a => BSTree a -> Bool
isBSTree' bst = bstxs == L.sort bstxs
  where 
    bstxs = inOrderVisitBSTree bst

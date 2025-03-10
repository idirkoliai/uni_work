import BSTree
import Data.Graph (Tree)
import Data.Maybe (fromJust)

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
heightBSTree Empty = -1
heightBSTree (Node lt _ rt) = 1 + max (heightBSTree lt) (heightBSTree rt)

leavesBSTree :: BSTree a -> [a]
leavesBSTree Empty = []
leavesBSTree (Node Empty x Empty) = [x]
leavesBSTree (Node lt _ rt) = leavesBSTree lt ++ leavesBSTree rt

elemBSTree :: (Ord a) => a -> BSTree a -> Bool
elemBSTree _ Empty = False
elemBSTree e (Node lt y rt)
  | e == y = True
  | e < y = elemBSTree e lt
  | otherwise = elemBSTree e rt

inOrderVisitBSTree :: BSTree a -> [a]
inOrderVisitBSTree Empty = []
inOrderVisitBSTree (Node lt r rt) = inOrderVisitBSTree lt ++ [r] ++ inOrderVisitBSTree rt

preOrderVisitBSTree :: BSTree a -> [a]
preOrderVisitBSTree Empty = []
preOrderVisitBSTree (Node lt r rt) = r : preOrderVisitBSTree lt ++ preOrderVisitBSTree rt

postOrderVisitBSTree :: BSTree a -> [a]
postOrderVisitBSTree Empty = []
postOrderVisitBSTree (Node lt r rt) = postOrderVisitBSTree lt ++ postOrderVisitBSTree rt ++ [r]

insertBSTree :: (Ord a) => BSTree a -> a -> BSTree a
insertBSTree Empty e = Node Empty e Empty
insertBSTree (Node lt r rt) e
  | e <= r = Node (insertBSTree lt e) r rt
  | otherwise = Node lt r (insertBSTree rt e)

fromListBSTree :: (Ord a) => [a] -> BSTree a
fromListBSTree = foldl insertBSTree Empty

toListBSTree :: BSTree a -> [a]
toListBSTree = inOrderVisitBSTree

mergeBSTree :: (Ord a) => BSTree a -> BSTree a -> BSTree a
mergeBSTree t1 t2 = foldl insertBSTree t1 (toListBSTree t2)

leftmostBSTree :: BSTree a -> Maybe a
leftmostBSTree Empty = Nothing
leftmostBSTree (Node Empty r _) = Just r
leftmostBSTree (Node lt _ _) = leftmostBSTree lt

minBSTree :: BSTree a -> Maybe a
minBSTree = leftmostBSTree

rightmostBSTree :: BSTree a -> Maybe a
rightmostBSTree Empty = Nothing
rightmostBSTree (Node _ r Empty) = Just r
rightmostBSTree (Node _ _ rt) = rightmostBSTree rt

maxBSTree :: BSTree a -> Maybe a
maxBSTree = rightmostBSTree

deleteRootBSTree :: (Ord a) => BSTree a -> BSTree a
deleteRootBSTree Empty = Empty
deleteRootBSTree (Node Empty r Empty) = Empty
deleteRootBSTree tree@(Node Empty _ rt) = rt
deleteRootBSTree tree@(Node lt _ rt) = Node newLeft maxleft rt
  where
    newLeft = deleteBSTree maxleft lt
    maxleft = fromJust $ rightmostBSTree lt

deleteBSTree :: (Ord a) => a -> BSTree a -> BSTree a
deleteBSTree _ Empty = Empty
deleteBSTree e tree@(Node lt r rt)
  | e < r = Node (deleteBSTree e lt) r rt
  | e > r = Node lt r (deleteBSTree e rt)
  | otherwise = deleteRootBSTree tree

mapBSTree :: (a -> b) -> BSTree a -> BSTree b
mapBSTree _ Empty = Empty
mapBSTree f (Node lt r rt) = Node (mapBSTree f lt) (f r) (mapBSTree f rt)

filterBSTree :: (Ord a) => (a -> Bool) -> BSTree a -> BSTree a
filterBSTree _ Empty = Empty
filterBSTree f tree@(Node lt r rt)
  | f r = Node (filterBSTree f lt) r (filterBSTree f rt)
  | otherwise = filterBSTree f (deleteBSTree r tree)

foldBSTree :: (a -> b -> b) -> b -> BSTree a -> b
foldBSTree _ acc Empty = acc
foldBSTree f acc (Node lt x rt) = foldBSTree f acc'' lt
  where
    acc' = foldBSTree f acc rt
    acc'' = f x acc'

countNodesBSTree' :: (Num b) => BSTree a -> b
countNodesBSTree' = foldBSTree (\_ acc -> acc + 1) 0

toListBSTree' :: BSTree a -> [a]
toListBSTree' = foldBSTree (:) []
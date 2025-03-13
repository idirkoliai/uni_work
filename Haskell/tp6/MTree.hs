import qualified Data.Foldable as F
import qualified Data.List     as L
import qualified Data.Tuple    as T 

data MTree a = MTree {rootLabel :: a, subForest :: MForest a} 
               deriving (Eq, Ord)

type MForest a = [MTree a]

mTreeIndent :: Int 
mTreeIndent = 4

mTreeBranchChar :: Char
mTreeBranchChar = '.'

mTreeNodeChar :: Char
mTreeNodeChar = '+'

instance (Show a) => Show (MTree a) where
  show = go 0
    where
      go nTabs MTree { rootLabel = rl, subForest = mts } =
          L.replicate nTabs mTreeBranchChar ++
          (if nTabs > 0 then " " else "")   ++
          mTreeNodeChar:" root label="      ++ 
          show rl                           ++
          "\n"                              ++
          F.foldr f "" mts
        where
          f mt acc = go (nTabs + mTreeIndent) mt ++ acc

mTreeMk :: a -> [MTree a] -> MTree a
mTreeMk rl mts = MTree { rootLabel = rl, subForest = mts} 

mTreeMkLeaf :: a -> MTree a
mTreeMkLeaf rl = mTreeMk rl []

mTreeMkExample :: MTree Integer 
mTreeMkExample = mTreeMk 6 [t1, t2, t3] where
  t1 = mTreeMk 4 [t4,t5]
  t2 = (mTreeMk 2 [(mTreeMk 3 [mTreeMkLeaf 2])])
  t3 = (mTreeMk 8 [t6,(mTreeMkLeaf 9),t7])
  t4 = (mTreeMk 2 [(mTreeMkLeaf 1),(mTreeMkLeaf 7),(mTreeMkLeaf 3)])
  t5 = (mTreeMk 5 [(mTreeMkLeaf 3),(mTreeMkLeaf 9)])
  t6 = (mTreeMk 7 [(mTreeMkLeaf 8)])
  t7 = (mTreeMk 2 [(mTreeMkLeaf 1),(mTreeMkLeaf 2),(mTreeMkLeaf 9),(mTreeMkLeaf 7),(mTreeMkLeaf 3)])


mTreeCount :: Num b => MTree a -> b -- qui calcule le nombre de nœuds d’un arbre général.
mTreeCount MTree { rootLabel = rl, subForest = mts } = 1 + F.sum (L.map mTreeCount mts)


mTreeIsLeaf :: MTree a -> Bool -- qui décide si un arbre général est une feuille. 
mTreeIsLeaf MTree { rootLabel = rl, subForest = mts } = L.null mts

mTreeLeaves :: MTree a -> [a] -- qui retourne la liste des feuilles d’un arbre général.
mTreeLeaves MTree { rootLabel = rl, subForest = mts } 
  | L.null mts = [rl]
  | otherwise  = F.concat $ map mTreeLeaves mts

mTreeCountLeaves :: Num b => MTree a -> b --qui calcule le nombre de feuilles d’un arbre général.
mTreeCountLeaves mtree = fromIntegral  (length (mTreeLeaves mtree))
  

mTreeSum :: Num a => MTree a -> a -- qui calcule la somme des étiquettes d’un arbre général.
mTreeSum MTree { rootLabel = rl, subForest = mts } = rl + F.sum (L.map mTreeSum mts)

mTreeToList :: MTree a -> [a] -- qui retourne la liste des étiquettes d’un arbre général. 
mTreeToList MTree { rootLabel = rl, subForest = mts } = rl : F.concat (L.map mTreeToList mts)

mTreeHeight :: (Num b, Ord b) => MTree a -> b -- qui calcule la hauteur d’un arbre général.
mTreeHeight tree@(MTree { rootLabel = rl, subForest = mts }) 
  | mTreeIsLeaf tree = 1
  | otherwise = 1 + maximum (L.map mTreeHeight mts)

mTreeElem :: Eq a => a -> MTree a -> Bool -- qui décide si une étiquette donnée appraît dans un arbre général.
mTreeElem x mtree@MTree { rootLabel = rl, subForest = mts }  = rl == x || F.or (L.map (mTreeElem x) mts)

mTreeMin :: Ord a => MTree a -> a -- qui calculent l’étiquette minimale
mTreeMin mtree@MTree { rootLabel = rl, subForest = mts } 
  |mTreeIsLeaf mtree = rl
  |otherwise = min rl $ head $ map mTreeMin mts

mTreeMax :: Ord a => MTree a -> a -- qui calculent l’étiquette maximale d’un arbre général
mTreeMax mtree = L.maximum $ mTreeToList mtree

--Exo 2
mTreeDepthFirstTraversal :: MTree a -> [a] -- qui réalise un parcours en profondeur d’abord d’un arbre général.
mTreeDepthFirstTraversal = mTreeToList


mTreeBreadthFirstTraversal :: MTree a -> [a] 
mTreeBreadthFirstTraversal mtree = go [mtree]
  where
    go [] = []
    go mts = L.map rootLabel mts ++ go (F.concatMap subForest mts)

mTreeLayer :: Int -> MTree a -> [a]
mTreeLayer n mtree@MTree { rootLabel = rl, subForest = mts } 
  | n == 0 = []
  | n == 1 = [rl]
  | L.null mts = []
  | otherwise = F.concatMap  (mTreeLayer (n-1)) mts 
-- Exo 3

mTreeFold1 :: (a -> b -> b) -> b -> MTree a -> [b]
mTreeFold1 f z MTree { rootLabel = rl, subForest = mts }
  | L.null mts = [f rl z]
  | otherwise  = [f rl y | mt <- mts, y <- mTreeFold1 f z mt]

mTreeFold2 :: (a -> [b] -> b) -> MTree a -> b 
mTreeFold2 f mt = f rl xs
  where
    rl = rootLabel mt
    xs = L.map (mTreeFold2 f) mts
      where
        mts = subForest mt


mTreeMap :: (a -> b) -> MTree a -> MTree b
mTreeMap f MTree { rootLabel = rl, subForest = mts } = MTree { rootLabel = f rl, subForest = L.map (mTreeMap f) mts }

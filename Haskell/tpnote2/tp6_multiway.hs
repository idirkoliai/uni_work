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
  t2 = (mTreeMk 2 [(mTreeMk 3 [mTreeMkLeaf 1])])
  t3 = (mTreeMk 8 [t6,(mTreeMkLeaf 9),t7])
  t4 = (mTreeMk 2 [(mTreeMkLeaf 1),(mTreeMkLeaf 7),(mTreeMkLeaf 3)])
  t5 = (mTreeMk 5 [(mTreeMkLeaf 3),(mTreeMkLeaf 9)])
  t6 = (mTreeMk 7 [(mTreeMkLeaf 8)])
  t7 = (mTreeMk 2 [(mTreeMkLeaf 1),(mTreeMkLeaf 2),(mTreeMkLeaf 9),(mTreeMkLeaf 7),(mTreeMkLeaf 3)])


mTreeCount :: Num b => MTree a -> b -- qui calcule le nombre de nœuds d’un arbre général.
mTreeCount MTree{rootLabel = r , subForest = sb} = 1 + sum (map mTreeCount sb)







mTreeIsLeaf :: MTree a -> Bool -- qui décide si un arbre général est une feuille. 
mTreeIsLeaf MTree{subForest = sb} 
    | null sb = True
    |otherwise = False


mTreeLeaves :: MTree a -> [a] -- qui retourne la liste des feuilles d’un arbre général.
mTreeLeaves mt@MTree{subForest = sb} 
    | null sb = [rootLabel mt]
    | otherwise = concatMap mTreeLeaves sb 
mTreeCountLeaves :: Num b => MTree a -> b --qui calcule le nombre de feuilles d’un arbre général.
mTreeCountLeaves mt 
  |mTreeIsLeaf mt = 1
  |otherwise = sum $ map mTreeCountLeaves $ subForest mt


mTreeSum :: Num a => MTree a -> a -- qui calcule la somme des étiquettes d’un arbre général.
mTreeSum mt = rootLabel mt  + sum (map mTreeSum $ subForest mt)


mTreeToList :: MTree a -> [a] -- qui retourne la liste des étiquettes d’un arbre général.
mTreeToList mt
  | mTreeIsLeaf mt = [rootLabel mt]
  | otherwise = rootLabel mt : concatMap mTreeToList (subForest mt)
  
mTreeHeight :: (Num b, Ord b) => MTree a -> b -- qui calcule la hauteur d’un arbre général.
mTreeHeight mt 
  | mTreeIsLeaf mt = 1
  | otherwise =  1 + L.maximum (map mTreeHeight $ subForest mt) 

mTreeElem :: Eq a => a -> MTree a -> Bool -- qui décide si une étiquette donnée appraît dans un arbre général.
mTreeElem  e mt 
  | rootLabel mt == e = True
  | (not.mTreeIsLeaf) mt && rootLabel mt /= e = False
  | otherwise = any (mTreeElem e)  $ subForest mt    

mTreeMin :: Ord a => MTree a -> a -- qui calculent l’étiquette minimale
mTreeMin  = L.minimum.mTreeToList 

mTreeMax :: Ord a => MTree a -> a -- qui calculent l’étiquette maximale d’un arbre général
mTreeMax = L.maximum.mTreeToList



-- Exo 4 

mTreeDepthFirstTraversal :: MTree a -> [a] 
mTreeDepthFirstTraversal = mTreeToList



mTreeBreadthFirstTraversal :: MTree a -> [a] 
mTreeBreadthFirstTraversal mtree = go [mtree]
  where
    go [] = []
    go mts = L.map rootLabel mts ++ go (F.concatMap subForest mts)


mTreeLayer :: Int -> MTree a -> [a]
mTreeLayer n mt
  | n == 0 = [] 
  | n == 1 = [rootLabel mt]
  | otherwise = concatMap (mTreeLayer (n-1)) (subForest mt) 
-- Exo 3


mTreeMap :: (a -> b) -> MTree a -> MTree b
mTreeMap f mt = MTree{rootLabel = (f.rootLabel) mt , subForest = map (mTreeMap f) (subForest mt) }


mTreeFilter :: (a -> Bool) -> MTree a -> MForest a
mTreeFilter f mt
  | labelMatches = [MTree { rootLabel = rootLabel mt, subForest = filteredChildren }]
  | not labelMatches && not (null filteredChildren) = filteredChildren
  | otherwise = []
  where
    labelMatches = f (rootLabel mt)
    filteredChildren = concatMap (mTreeFilter f) (subForest mt)







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


mTreeCollectPaths :: MTree a -> [[a]]
mTreeCollectPaths  = mTreeFold1 (:) []

mTreeSignature :: (Num a) => MTree a -> [a]
mTreeSignature = mTreeFold1 (+) 0


mTreeMin' :: Ord a => MTree a -> a
mTreeMin' = mTreeFold2 (\x acc -> L.minimum $ x:acc) 



mTreeMax' :: Ord a => MTree a -> a
mTreeMax' = mTreeFold2 (\x acc -> L.maximum $ x:acc) 

mTreeToList' :: MTree a -> [a]
mTreeToList' = mTreeFold2 (\x bs -> x : concat bs)

mTreeIsoTopology :: MTree a -> MTree b -> Bool
mTreeIsoTopology mt1 mt2 
  | l1 /= l2 = False
  | mTreeIsLeaf mt1 && mTreeIsLeaf mt2 = True 
  |otherwise = or [ mTreeIsoTopology mt1' mt2' | (mt1',mt2') <- zippedTrees  ] 
  where 
    l1 = length $ subForest mt1
    l2 = length $ subForest mt2
    zippedTrees = zip (subForest mt1) (subForest mt2)


mTreeCut :: (Eq b, Num b) => b -> MTree a -> MTree a
mTreeCut n mtree 
  | n == 1 = MTree{rootLabel = rootLabel mtree, subForest = []}
  | mTreeIsLeaf mtree = mtree
  |otherwise = MTree{rootLabel = rootLabel mtree, subForest = sb}
  where 
    sb = map (mTreeCut (n-1)) ( subForest mtree)  
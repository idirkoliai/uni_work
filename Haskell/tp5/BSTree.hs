module BSTree where
import qualified Data.List as L

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

instance Show a => Show (BSTree a) where
  show = showBSTree 0
    where
      drawBranch 0 = ""
      drawBranch n = L.replicate (n - branchIndent) branchChar ++ [splitChar] ++ L.replicate (branchIndent-1) branchChar

      showBSTree n Empty          = drawBranch n ++ branchNil:"\n"
      showBSTree n (Node lt x rt) = showBSTree (n + branchIndent) rt ++
                                    drawBranch n ++ show x           ++ "\n" ++
                                    showBSTree (n + branchIndent) lt

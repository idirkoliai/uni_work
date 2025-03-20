module Countdown where

import qualified Data.Foldable as F
import qualified Data.List     as L

-- Inner type
type Value = Int

-- Arithmetic expression
data AExpr = Num Value | App BOp AExpr AExpr

-- Binary operator
data BOp = Add | Sub | Mul | Div

-- Computation (i.e., valued arithmetic expression)
newtype VAExpr = VAExpr (AExpr,Value)

instance Show BOp where
  show Add = "+"
  show Sub = "-"
  show Mul = "x"
  show Div = "/"

instance Show AExpr where
  show (Num x) = show x
  show (App op e1 e2) = "("      ++
                        show e1  ++
                        " "      ++
                        show op  ++
                         " "     ++
                        show e2  ++
                        ")"

instance Show VAExpr where
  show (VAExpr (e,v)) = show e ++ " = " ++ show v


sublists :: [a] -> [[a]]
sublists [] = []
sublists [x] = [[x]]
sublists (x:xs) = sublists xs ++ map (x:) (sublists xs)

legal1 :: BOp -> Value -> Value -> Bool
legal1 Add v1 v2 = True
legal1 Sub v1 v2 = v2 < v1
legal1 Mul v1 v2 = True
legal1 Div v1 v2 = v1 `mod` v2 == 0

apply :: BOp -> Value -> Value -> Value
apply Add v1 v2 = v1 + v2
apply Sub v1 v2 = v1 - v2
apply Mul v1 v2 = v1 * v2
apply Div v1 v2 = v1 `div` v2

value :: AExpr -> Value
value (Num x) = x
value (App op e1 e2) = apply op (value e1) (value e2)

merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge xs@(x : xs') ys@(y : ys')
  | x <= y = x : merge xs' ys
  | otherwise = y : merge xs ys'

unmerges1 :: [a] -> [([a], [a])]
unmerges1 [x,y] = [([x],[y]),([y],[x])] 
unmerges1 (x:xs) =
    [([x], xs)] ++ [(xs, [x])] ++ concatMap (\(ys, zs) -> [((x:ys), zs), (ys, x:zs)]) (unmerges1 xs)

combineVAExprs1 :: VAExpr -> VAExpr -> [VAExpr]
combineVAExprs1 (VAExpr (e1,v1)) (VAExpr (e2,v2)) =
  [VAExpr (App op e1 e2, apply op v1 v2) | op <- [Add, Sub, Mul, Div], legal1 op v1 v2]

mkAExprs1 :: [Int] -> [VAExpr]
mkAExprs1 [x] = [(VAExpr (Num x,x))]
mkAExprs1 xs = [ e | (ys,zs) <- unmerges1 xs, e1 <- mkAExprs1 ys, e2 <- mkAExprs1 zs, e <- combineVAExprs1 e1 e2]

searchBest :: Value -> [VAExpr] -> VAExpr
searchBest val [x] = x
searchBest val (VAExpr (e1,v1) : VAExpr (e2,v2) : es)
  | abs (v1 - val) <= abs (v2 - val) = searchBest val (VAExpr (e1,v1) : es)
  | otherwise = searchBest val (VAExpr (e2,v2) : es)

countdown1 :: Int -> [Int] -> VAExpr
countdown1 n xs = searchBest n (mkAExprs1 xs)
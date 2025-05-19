import Data.Foldable qualified as F
import Data.List qualified as L
import Data.Tuple qualified as T

-- cell index
type Cell = Int

-- vehical index
type VehicleI = Int

-- vehicle (from cell to cell): 2 consecutive cells for a car and 3 for a truck
newtype Vehicle = Vehicle (Cell, Cell) deriving (Show, Eq)

-- rush hour grid (only the vehicles)
newtype Grid = Grid {vehicles :: [Vehicle]} deriving (Show, Eq)

-- move vehicle to some adjacent cell (one cell distance)
newtype Move = Move (VehicleI, Cell) deriving (Show)

-- a path is a sequence of moves together with the resulting grid
newtype Path = Path ([Move], Grid) deriving (Show)

-- a frontier is a list of paths  (waiting to to be explored further)
newtype Frontier = Frontier [Path]

-- .   .   .   .   .   .
--
-- .   .   .   .   .   o
--                     |
-- .   .   o - o   .   o
--                     |
-- .   .   .   .   .   o
--
-- .   .   .   .   .   .
--
-- .   .   .   .   .   .
grid1 :: Grid
grid1 = Grid {vehicles = specialVehicle : otherVehicles}
  where
    specialVehicle = Vehicle (17, 18)
    otherVehicles = L.map Vehicle [(13, 27)]

-- o   o   o   o   o - o

-- |   |   |   |
-- o   o   o   o   o   o
-- |               |   |
-- o   .   o - o   o   o
--                     |
-- .   .   o - o - o   o
--
-- .   .   o   .   o - o
--         |
-- o - o   o   .   o - o
grid2 :: Grid
grid2 = Grid {vehicles = specialVehicle : otherVehicles}
  where
    specialVehicle = Vehicle (17, 18)
    otherVehicles = L.map Vehicle [(13, 27), (1, 15), (2, 9), (3, 10), (4, 11), (5, 6), (12, 19), (24, 26), (31, 38), (33, 34), (36, 37), (40, 41)]

-- o   .   .   o   .   o

-- |           |       |
-- o   .   .   o   .   o
-- |                   |
-- o   .   o - o   .   o
--
-- o - o   o   .   o   o
--         |       |   |
-- .   .   o   .   o   o
--
-- o - o   o - o   .   .
grid3 :: Grid
grid3 = Grid {vehicles = specialVehicle : otherVehicles}
  where
    specialVehicle = Vehicle (17, 18)
    otherVehicles = L.map Vehicle [(4, 11), (6, 20), (27, 34), (36, 37), (1, 15), (22, 23), (26, 33), (24, 31), (38, 39)]

-- o   .   .   o - o - o

-- |
-- o   o - o   o   .   .
--             |
-- o - o   o   o   .   o
--         |           |
-- .   .   o   .   .   o
--                     |
-- .   .   o   o - o   o
--         |
-- .   .   o   o - o - o
vehicleRearCell :: Vehicle -> Cell
vehicleRearCell (Vehicle (r, _)) = r

vehicleFrontCell :: Vehicle -> Cell
vehicleFrontCell (Vehicle (_, f)) = f

specialVehicle :: Grid -> Vehicle
specialVehicle = L.head . vehicles

isHorizontalVehicle :: Vehicle -> Bool
isHorizontalVehicle (Vehicle (r, f)) = r > f - 7

isVerticalVehicle :: Vehicle -> Bool
isVerticalVehicle = not . isHorizontalVehicle

exitCell :: Cell
exitCell = 20

leftmostCellInRow :: Cell -> Cell
leftmostCellInRow c = 1 + 7 * (c `div` 7)

rightmostCellInRow :: Cell -> Cell
rightmostCellInRow c = 5 + leftmostCellInRow c

topmostCellInColumn :: Cell -> Cell
topmostCellInColumn c = c `mod` 7

bottommostCellInColumn :: Cell -> Cell
bottommostCellInColumn c = 35 + topmostCellInColumn c

validCellPath :: Cell -> Bool
validCellPath c = c > 0 && (c `mod` 7) /= 0 && c < 42

-- show grid functions

emptyGridStr :: [String]
emptyGridStr = L.intersperse iLine lines
  where
    iLine = L.concat (L.replicate 21 " ") ++ "\n"
    line = L.intercalate "   " (L.replicate 6 ".") ++ "\n"
    lines = L.replicate 6 line

updateGridStr :: (Int, Int) -> Char -> [String] -> [String]
updateGridStr (r, c) ch ss = lss ++ [l] ++ rss
  where
    (lss, s : rss) = L.splitAt (r - 1) ss
    (lcs, _ : rcs) = L.splitAt (c - 1) s
    l = lcs ++ [ch] ++ rcs

hVehicleUpdateGridStr :: Vehicle -> [String] -> [String]
hVehicleUpdateGridStr (Vehicle (r, f)) = go r
  where
    go c ss
      | c < f =
          go (c + 1)
            . updateGridStr (i, j + 2) '-'
            . updateGridStr (i, j) 'o'
            $ ss
      | otherwise = updateGridStr (i, j) 'o' ss
      where
        i = 2 * (r `div` 7) + 1
        j = 4 * ((c - 1) `mod` 7) + 1

vVehicleUpdateGridStr :: Vehicle -> [String] -> [String]
vVehicleUpdateGridStr (Vehicle (r, f)) = go r
  where
    go c ss
      | c < f =
          go (c + 7)
            . updateGridStr (i + 1, j) '|'
            . updateGridStr (i, j) 'o'
            $ ss
      | otherwise = updateGridStr (i, j) 'o' ss
      where
        i = 2 * (c `div` 7) + 1
        j = 4 * ((c - 1) `mod` 7) + 1

vehicleUpdateGridStr :: Vehicle -> [String] -> [String]
vehicleUpdateGridStr v@(Vehicle (r, f)) ss
  | isHorizontalVehicle v = hVehicleUpdateGridStr v ss
  | otherwise = vVehicleUpdateGridStr v ss

toString :: Grid -> String
toString = L.concat . F.foldr vehicleUpdateGridStr emptyGridStr . vehicles

countVehicles :: Grid -> Int
countVehicles g = length $ vehicles g

isCar :: Vehicle -> Bool
isCar (Vehicle (start, end)) = end - start == 1 || end - start == 7

isTruck :: Vehicle -> Bool
isTruck = not . isCar

allCells :: [Cell]
allCells = [n | n <- [1 .. 41], n `mod` 7 /= 0]

fillCells :: Vehicle -> [Cell]
fillCells v
  | isCar v = [vehicleRearCell v, vehicleFrontCell v]
  | otherwise = if isHorizontalVehicle v then [vehicleRearCell v, vehicleRearCell v + 1 .. vehicleFrontCell v] else [vehicleRearCell v, vehicleRearCell v + 7 .. vehicleFrontCell v]

occupiedCells :: Grid -> [Cell]
occupiedCells (Grid vs) = concatMap fillCells vs

freeCells :: Grid -> [Cell]
freeCells grid = filter (not . (`elem` occupiedCells grid)) allCells

adjCells :: Vehicle -> [Cell]
adjCells v@(Vehicle (rear, front))
  | isHorizontalVehicle v = filter validCellPath [rear - 1, front + 1]
  | otherwise = filter validCellPath [rear - 7, front + 7]

legalMoves :: Grid -> [Move]
legalMoves (Grid vs) = concatMap (\(i, v) -> [Move (i, c) | c <- adjCells v, c `notElem` occupiedCells (Grid vs)]) $ zip [0 ..] vs

moveVehicleTowards :: Vehicle -> Cell -> Vehicle
moveVehicleTowards (Vehicle (r, f)) c
  | c < r = Vehicle (c, f - (r - c))
  | otherwise = Vehicle (r + (c - f), c)

move :: Grid -> Move -> Grid
move (Grid (v : vs)) (Move (i, dest))
  | i == 0 = Grid (moveVehicleTowards v dest : vs)
  | otherwise = Grid (v : vehicles (move (Grid vs) (Move (i - 1, dest))))

isSolved :: Grid -> Bool
isSolved grid = (vehicleFrontCell $ specialVehicle grid) == 20 || (vehicleRearCell $ specialVehicle grid) == 20

succPaths :: Path -> [Path]
succPaths (Path ([], grid)) = map (\m -> Path ([m], move grid m)) (legalMoves grid)

bfsSearch :: [Grid] -> Frontier -> Maybe [Move]
bfsSearch _ (Frontier []) = Nothing
bfsSearch visited (Frontier (Path (ms, grid) : rest))
  | isSolved grid = Just (reverse ms)
  | grid `elem` visited = bfsSearch visited (Frontier rest)
  | otherwise =
      let newPaths = [Path (m : ms, move grid m) | m <- legalMoves grid]
       in bfsSearch (grid : visited) (Frontier (rest ++ newPaths))

bfsSolve :: Grid -> Maybe [Move]
bfsSolve grid = bfsSearch [] (Frontier [Path ([], grid)])
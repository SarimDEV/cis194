module Golf where

skips :: [a] -> [[a]]
skips xs = [ [x | (x, i) <- zip xs [1..], mod i n == 0] | n <- [1..length xs]]

localMaxima :: [Integer] -> [Integer]
localMaxima v = map (\(_,y,_) -> y) (filter (\(x,y,z) -> y > x && y > z) (zip3 v (drop 1 (take (length v - 1) v)) (drop 2 v)))

freq :: [Integer] -> [Int]
freq l = [length (filter (==n) l) | n <- [0..9]]
--
f :: [Int] -> Int -> [[Bool]]
f arr m = reverse [ map (>=i) arr | i <- [1..m]]

fmt :: [Bool] -> String
fmt = concatMap (\x -> if x then "*" else " ")

fmtAll :: [[Bool]] -> String
fmtAll = concatMap ((++ "\n") . fmt)

histogram :: [Integer] -> String
histogram p = fmtAll(f (freq p) (maximum (freq p))) ++ "==========\n0123456789\n"

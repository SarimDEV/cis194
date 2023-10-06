module Golf where

skips :: [a] -> [[a]]
skips xs = [ [x | (x, i) <- zip xs [1..], mod i n == 0] | n <- [1..length xs]]

localMaxima :: [Integer] -> [Integer]
localMaxima v = map (\(_,y,_) -> y) (filter (\(x,y,z) -> y > x && y > z) (zip3 v (drop 1 (take (length v - 1) v)) (drop 2 v)))

freq :: [Integer] -> [Int]
freq l = [length (filter (==n) l) | n <- [0..9]]
--
f :: [Int] -> [[String]]
f arr = reverse [ map (\x -> if x >= i then "*" else " ") arr | i <- [1..maximum arr]]

histogram p = unlines line ++ "==========\n0123456789\n"
    where line = map concat (f (freq p))

type Peg = String
type Move = (Peg, Peg)

hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi 0 a b c = []
hanoi n a b c = hanoi (n-1) a c b ++ [(a,c)] ++ hanoi (n-1) b a c

moveToStr :: Move -> String
moveToStr (x, y) = x ++ "->" ++ y ++ "\n"

outputHanoi :: [Move] -> [String]
outputHanoi = map moveToStr


main = do
    putStrLn (concat (outputHanoi (hanoi 5 "a" "b" "c")))

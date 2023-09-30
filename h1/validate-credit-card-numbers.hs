rev :: [Integer] -> [Integer]
rev xs = go xs []
    where
    go :: [a] -> [a] -> [a]
    go [] ys = ys
    go (x: xs) ys = go xs (x:ys)


toDigitsRev :: Integer -> [Integer]
toDigitsRev 0 = []
toDigitsRev num = num `mod` 10 : toDigitsRev (num `div` 10)

toDigits :: Integer -> [Integer]
toDigits num = rev (toDigitsRev num)

doubleEveryOtherLR :: [Integer] -> [Integer]
doubleEveryOtherLR [] = []
doubleEveryOtherLR [x] = [x]
doubleEveryOtherLR (x:(y:l)) = x : y*2 : doubleEveryOtherLR l


doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther l = rev (doubleEveryOtherLR (rev l))

sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits [x] = sum(toDigitsRev x )
sumDigits (x:l) = sum(toDigitsRev x) + sumDigits l

validate :: Integer -> Bool
validate num = sumDigits(doubleEveryOther(toDigits num )) `mod` 10 == 0

main = do
  putStrLn ("Hi" ++ show (validate 4012888888881882))



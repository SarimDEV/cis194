{-# OPTIONS_GHC -Wall #-}

module LogAnalysis where

import Log

-- <type> <timestamp> <message>
-- <type> <errorCode> <timestamp> <message>

parseMessage :: String -> LogMessage
parseMessage str = case str of
  ('I' : ' ' : s) -> LogMessage Info (read (head (words s)) :: Int) (unwords (drop 2 (words s)))
  ('W' : ' ' : s) -> LogMessage Warning (read (head (words s)) :: Int) (unwords (drop 2 (words s)))
  ('E' : ' ' : s) -> LogMessage (Error (read (head (words s)) :: Int)) (read (words s !! 1) :: Int) (unwords (drop 2 (words s)))
  s -> Unknown s

parse :: String -> [LogMessage]
parse s = map parseMessage (lines s)

insert :: LogMessage -> MessageTree -> MessageTree
insert l Leaf = Node Leaf l Leaf
insert a@(LogMessage _ timeStamp _) (Node l c@(LogMessage _ v _) r)
  | v == timeStamp = Node l c r
  | v < timeStamp = Node l c (insert a r)
  | v > timeStamp = Node (insert a l) c r
insert _ t = t

build :: [LogMessage] -> MessageTree
build [] = Leaf
build logs = foldl (flip insert) Leaf logs

inOrder :: MessageTree -> [LogMessage]
inOrder (Node l v r) = inOrder l ++ [v] ++ inOrder r
inOrder Leaf = []

logMessageToString :: LogMessage -> String
logMessageToString (LogMessage _ _ str) = str
logMessageToString (Unknown str) = str

filterWrongLogs :: LogMessage -> Bool
filterWrongLogs (LogMessage (Error severity) _ _)
    | severity >= 50 = True
    | otherwise = False
filterWrongLogs _ = False

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong l = map logMessageToString (filter filterWrongLogs (inOrder (build l)))

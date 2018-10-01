import Debug.Trace
import Data.List
import Data.Char 

data Edge = Edge { node::Node, weight::Float } deriving (Eq,Show,Read)
type Node = String
type Graph = [(Node, [Edge])]
type Dnode = (Node, (Float, Node))


main = do 
	input <- getContents
    	let infos = lines input
	let start = getRoute head infos                                         
       	let end = getRoute last infos
	let cleanText = cleanInput infos
	let text = (intercalate "\n" cleanText)
	let g = fromText text True
	let soln = dijkstra g start
	let solution = listToNode soln end
	print solution
	print (weightForDnode (last(pathToNode soln end)))

weightForDnode :: Dnode -> Float
weightForDnode (_, (w, _)) = w

buildLines [] = []
buildLines (x:xs) = if length xs > 0 then [x ++ " " ++ head(xs)] ++ buildLines(xs)
			else []  

--Obter nome da linha de acordo com referencias, por exemplo: a b 
getLineName linha [] = ""
getLineName linha (x:xs) = if (isInfixOf linha x) then (head((wordsWhen (==' ') (replace x linha ""))))
			    	else getLineName linha xs

--Obter o tempo de espera de acordo com o nome da linha, por exemplo: linha-456
getWaiting linha [] = 0
getWaiting linha (x:xs) = if (isInfixOf linha x) then ((digitToInt(head(last((wordsWhen (==' ') x))))) `div` 2)
			    	else getWaiting linha xs

dijkstra :: Graph -> Node -> [Dnode]
dijkstra g start = 
  let dnodes = initD g start
      unchecked = map fst dnodes
  in  dijkstra' g dnodes unchecked

initD :: Graph -> Node -> [Dnode]
initD g start =
  let initDist (n, es) = 
        if n == start 
        then 0 
        else if start `elem` connectedNodes es
             then weightFor start es
             else 1.0/0.0
  in map (\pr@(n, _) -> (n, ((initDist pr), start))) g

dijkstra' :: Graph -> [Dnode] -> [Node] -> [Dnode]
dijkstra' g dnodes [] = dnodes
dijkstra' g dnodes unchecked = 
  let dunchecked = filter (\dn -> (fst dn) `elem` unchecked) dnodes
      current = head . sortBy (\(_,(d1,_)) (_,(d2,_)) -> compare d1 d2) $ dunchecked
      c = fst current
      unchecked' = delete c unchecked
      edges = edgesFor g c
      cnodes = intersect (connectedNodes edges) unchecked'
      dnodes' = map (\dn -> update dn current cnodes edges) dnodes
  in dijkstra' g dnodes' unchecked' 

update :: Dnode -> Dnode -> [Node] -> [Edge] -> Dnode
update dn@(n, (nd, p)) (c, (cd, _)) cnodes edges =
  let wt = weightFor n edges
  in  if n `notElem` cnodes then dn
      else if cd+wt < nd then (n, (cd+wt, c)) else dn

pathToNode dnodes dest = 
  let dn@(n, (d, p)) = dnodeForNode dnodes dest
  in if n == p then [dn] else pathToNode dnodes p ++ [dn]

listToNode :: [Dnode] -> Node -> [Node]
listToNode dnodes dest = 
  let dn@(n, (d, p)) = dnodeForNode dnodes dest
  in if n == p then [n] else listToNode dnodes p ++ [n]

replace :: Eq a => [a] -> [a] -> [a] -> [a]
replace [] _ _ = []
replace s find repl =
    if take (length find) s == find
        then repl ++ (replace (drop (length find) s) find repl)
        else [head s] ++ (replace (tail s) find repl)

countLetters :: String -> Char -> Int
countLetters str c = length $ filter (== c) str

trim :: String -> String
trim = f . f
   where f = reverse . dropWhile isSpace

wordsWhen     :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'

cleanInput [] = []
cleanInput (x:xs) =  
	if (countLetters x ' ') > 2 then 
		if (isInfixOf "a-pe" x) then [trim $ replace x "a-pe " ""] ++ cleanInput(xs)
		else [take 3 x ++ " " ++ last(wordsWhen (==' ') x)] ++ cleanInput(xs)
	else []

fromText :: String -> Bool -> Graph
fromText strLines isDigraph = 
  let readData [n1, n2, w] = ((n1, n2), read w :: Float)
      es = map (readData . words) $ lines strLines
      allEs = if isDigraph then es 
              else appendReversed es
  in fromList allEs

appendReversed :: [((String, String), Float)] -> [((String, String), Float)]
appendReversed es = es ++ map (\((n1,n2),w) -> ((n2,n1),w)) es

fromList :: [((String, String), Float)] -> Graph
fromList es =
  let nodes = nub . map (fst . fst) $ es
      edgesFor es node = 
        let connected = filter (\((n,_),_) -> node == n) $ es
        in map (\((_,n),wt) -> Edge n wt) connected 
  in map (\n -> (n, edgesFor es n)) nodes

getLines infos = filter (\n -> isInfixOf "linha-" n && countLetters n ' ' == 1) infos

getLinesInfo infos = filter (\n -> isInfixOf "linha-" n && countLetters n ' ' > 2) infos

getRoute ref linha = (ref (words $ last linha))

edgesFor :: Graph -> Node -> [Edge]
edgesFor g n = snd . head . filter (\(nd, _) -> nd == n) $ g

weightFor :: Node -> [Edge] -> Float
weightFor n = weight . head . filter (\e -> n == node e)

connectedNodes :: [Edge] -> [Node]
connectedNodes = map node

dnodeForNode :: [Dnode] -> Node -> Dnode
dnodeForNode dnodes n = head . filter (\(x, _) -> x == n) $ dnodes

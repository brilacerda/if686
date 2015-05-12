--Questão 1

tiraEspaco :: String -> String
tiraEspaco [] = []
tiraEspaco (s:tr)
   |s == ' ' = tiraEspaco tr
   |otherwise = (s : (tiraEspaco tr))

concatStr :: String -> String -> String
concatStr str strgs = str ++ (tiraEspaco str)


main :: IO ()
main = do 
	str <- getLine
	if(str == "")
	  then putStrLn (tiraEspaco str)
	  else putStr "" 
	main


--funcionando sem salvar
main' :: IO ()
main' = do 
	str <- getLine
	putStrLn (tiraEspaco str)
	main'



{-
--lembrar como fazer aquele negócio de 
a <- getLine
b <- fun a main

fun :: String -> String
fun str
  |str /= '' = (tiraEspaco str)
  |otherwise = 
-}

--Questão 2

data Graph t = NulG | No [t] [(t, t)]
       deriving (Show, Eq)

data Tree t = NulT | Nod t (Tree t) (Tree t)
       deriving (Eq, Ord, Show)

tree :: (Num t) => Tree t
tree = Nod 3 (Nod 4 NulT NulT) (Nod 7 NulT (Nod 0 NulT NulT))

member :: Eq t => [t] -> t -> Bool
member list x = (length [l | l <- list , l == x]) > 0

{-
checkMembership :: [t] -> t -> t -> t -> 
checkMembership nos a b c 
   |member nos a = 
-}

toGraph :: t -> t -> t -> Graph t
toGraph a e r = No [a, e , r] [(a, e), (a, r)]
--toGraph (No nos edges) a e r = No (checkMembership nos a e r) 

toGraphEsq :: t -> t -> Graph t
toGraphEsq a e = No [a, e] [(a, e)]

toGraphDir :: t -> t -> Graph t
toGraphDir a r = No [a, r] [(a, r)]

blend :: Graph t -> Graph t -> Graph t -> Graph t
blend graph NulG NulG = graph
blend (No nos edges) (No noEsq edEsq) NulG = No (nos ++ noEsq) (edges ++ edEsq)
blend (No nos edges) NulG (No noDir edDir) = No (nos ++ noDir) (edges ++ edDir)
blend (No nos edges) (No noEsq edEsq) (No noDir edDir) = No (nos ++ noEsq ++noDir) (edges ++ edDir ++ edEsq)

transforma :: Tree t -> Graph t
transforma NulT = NulG
transforma (Nod n NulT NulT) = No [n] []
transforma (Nod n  (Nod e x y) NulT) = blend ((toGraphEsq n e) (transforma (Nod e x y)) NulG)
transforma (Nod n  NulT (Nod r z v)) = blend ((toGraphDir n r) NulG (transforma (Nod r z v)))
transforma (Nod n  (Nod e x y) (Nod r z v)) =  blend ((toGraph n e r) (transforma (Nod e x y)) (transforma (Nod r z v)))


{-
criarGrafo :: [Tree t] -> Graph t
criarGrafo NulT = NulG
criarGrafo (tr:trs) = (transforma tr)
-}
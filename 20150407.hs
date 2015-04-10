data Shape = Circle Float | Rectangle Float Float
area :: Shape -> Float
area (Circle r) = pi*r*r
area (Rectangle c l) = c*l

type HorasAula = Int
type Disciplina = [String]

--Segunda, Terca, Quarta, Quinta, Sexta, Sabado e Domingo são construtores
data Dia = Segunda HorasAula Disciplina| Terca HorasAula Disciplina| Quarta HorasAula Disciplina| Quinta HorasAula Disciplina| Sexta HorasAula Disciplina| Sabado | Domingo

ehFDS :: Dia -> Bool
ehFDS Sabado = True
ehFDS Domingo = True
ehFDS _ = False

-- definicão preguiçosa
temPLC :: Dia -> Bool
temPLC (Terca _ _) = True
temPLC (Quinta _ _) = True
temPLC (_         ) = False

-- definicão não preguiçosa
plcHoje :: Dia -> Bool
plcHoje Sabado = False
plcHoje Domingo = False
plcHoje (Segunda h dis) = contido dis "PLC"
plcHoje (Terca h dis) = contido dis "PLC"
plcHoje (Quinta h dis) = contido dis "PLC"
plcHoje (Quarta h dis) = contido dis "PLC"
plcHoje (Sexta h dis) = contido dis "PLC"

contido :: Disciplina -> String -> Bool
contido [] xis = False
contido (a:as) xis
    |a == xis = True
    |otherwise = contido as xis

data Expr = Lit Int |
   Add Expr Expr |
   Sub Expr Expr

data List t = Nul |
   Cons t (List t)
   deriving (Show)

data Tree t = NulT |
   Node t (Tree t) (Tree t) 
   deriving (Eq, Show)

--ex. de teste usando construtor showExpr (Add (Lit 7) (Lit 6))
showExpr :: Expr -> String
showExpr (Lit x) = show x
showExpr (Add a b) = showExpr a ++ " + " ++ showExpr b
showExpr (Sub a b) = showExpr a ++ " - " ++ showExpr b

--ex. teste toList (Cons 8 (Nul)) / toList (Cons 8 (Cons 4 (Cons 6 (Nul))))
toList :: List t -> [t]
toList (Nul) = []
toList (Cons x ls) = (x:(toList ls))

fromList :: (Show t) => [t] -> List t
fromList [] = Nul
fromList (l:ls) = (Cons l (fromList ls))

-- teste depth (Node 5 (Node 3 (NulT) (NulT)) (Node 2 (Node 3 (NulT) (NulT)) (NulT)))
depth :: Tree t -> Int
depth NulT = 0
depth (Node c a b) = 1 + max (depth a) (depth b)

--mapTree (2*) (Node 5 (Node 3 (NulT) (NulT)) (Node 2 (Node 3 (NulT) (NulT)) (NulT)))

mapTree:: (t -> u) -> Tree t -> Tree u
mapTree fun NulT = NulT
mapTree fun (Node x a b) = Node (fun x) (mapTree fun a) (mapTree fun b)
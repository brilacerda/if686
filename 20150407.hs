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

data List t = Nil |
   Cons t (List t)

data Tree t = NilT |
   Node t (Tree t) (Tree t) 
   deriving (Eq, Show)

showExpr :: Expr -> String
showExpr (Lit x) = show x
showExpr (Add a b) = showExpr a ++ " + " ++ showExpr b
showExpr (Sub a b) = showExpr a ++ " - " ++ showExpr b


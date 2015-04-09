import Data.Char

-- Trabalho 6
data Nodes t = Node Float t [(Nodes t)] 
   deriving (Eq, Show)

data DirectedGraph t = DirectedGraph [(Nodes t)]
   deriving (Eq, Show)
   
findDFS :: DirectedGraph t -> t -> Bool
findDFS [] v = False
findDFS (Node peso valor ((Node p n []):graph) ) v 
   |valor == n || valor == v = True
   |otherwise = findDFS graph v

findDFS (Node peso valor graph) v 
   |valor == v = True
   |otherwise = findDFS (head graph) v -- não folha

--Exercicios de Aula

squareRoot a = map sqrt a

praAlfabeto :: Char -> Int
praAlfabeto a = (ord a - 96)

posicaoAlfabeto s = map praAlfabeto s

--antes da | na compressão de lista entra a condição, 
--após a vírgula são apenas condições, nesse caso não existe
map :: (t -> u) -> [t] -> [u]
map f [] = []
map f list = [f a| a <- list]

member :: (Eq t) => t -> [t] -> Bool
member x lis = foldr (||) False (map (==x) lis)

--not working 
naoExiste :: t -> [t] -> [t]
naoExiste x [] = (x:[])
naoExiste x (a:as)
   |x == a = []
   |otherwise = naoExiste x as

removeRepetido :: [t] -> [t]
removeRepetido lista = [x| x <- lista, naoExiste x lista]

union :: [t] -> [t] -> [t]
union a b = foldr naoExiste [] (a ++ b)

import Data.Char

-- Trabalho 6

-- [lista de nós] [aresta, aresta, peso]
data DirectedGraph t = DirectedGraph [t] [(t, t, Int)]
   deriving (Eq, Show)

{-   
findDFS :: DirectedGraph t -> t -> Bool
findDFS Nul v = False
findDFS (Node peso valor ((Node p n []):graph) ) v 
   |valor == n || valor == v = True
   |otherwise = findDFS graph v

findDFS (Node peso valor graph) v 
   |valor == v = True
   |otherwise = findDFS (head graph) v -- não folha
-}

--Exercicios de Aula

squareRoot a = map sqrt a

praAlfabeto :: Char -> Int
praAlfabeto a = (ord a - 96)

posicaoAlfabeto s = map praAlfabeto s

--antes da | na compressão de lista entra a condição, 
--após a vírgula são apenas condições, nesse caso não existe
map2 :: (t -> u) -> [t] -> [u]
map2 f [] = []
map2 f list = [f a| a <- list]

member :: (Eq t) => t -> [t] -> Bool
member x lis = foldr (||) False (map (==x) lis)

--union
unir :: (Eq t) => t -> [t] -> [t]
unir x lis 
   |member x lis = lis
   |otherwise = x:lis

toSet :: (Eq t) => [t] -> [t]
toSet list = foldr unir [] list

union :: (Eq t) => [t] -> [t] -> [t]
union a b = foldr unir (toSet a) b
--fim Union

usandoOrd :: Char -> Int -> Int
usandoOrd c ac = (ord c - 96) + ac

--usando decentemente o map e o foldr
toAlphabet :: String -> Int
toAlphabet pal = foldr usandoOrd 0 pal

--O retorno da função passada por parâmetro é sempre  
--do tipo de retorno do foldr
alphabetSum :: [[Char]] -> [Int]
alphabetSum list = (map toAlphabet list)

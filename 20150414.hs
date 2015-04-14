--Trabalho 7

--Questão 1

--(head (compose (+ 1) [(* 2), (/ 2), (+ 4)])) 5

compose :: (Show t) => (t -> t) -> [(t -> t)] -> [(t -> t)]
compose g [] = []
compose g (f:fs) = ((g . f) : compose g fs)

--Questão 2
data Graph t = Graph [t] [(t, t, Int)]
   deriving (Eq, Show)

-- mapGraph (*2) (Graph [2, 3, 4, 6] [(2,3,5), (6, 4, 2), (3, 4, 0), (3, 2, 1)])

changeEdges :: (t -> u) -> [(t, t, Int)] -> [(u, u, Int)]
changeEdges f [] = []
changeEdges f ((a, b, c):as) = (((f a), (f b), c) : (changeEdges f as))

mapGraph :: (t -> u) -> Graph t -> Graph u
mapGraph f (Graph [] []) = (Graph [] [])
mapGraph f (Graph nos arestas) = Graph (map f nos) (changeEdges f arestas)

-- foldGraph sumWeight 0 (Graph [2, 3, 4, 6] [(2,3,5), (6, 4, 2), (3, 4, 0), (3, 2, 1)])

foldGraph :: ((t, t, Int) -> u -> u) -> u  -> Graph t -> u
foldGraph f base (Graph _ []) = base
foldGraph f base (Graph nos ((a, b ,c):as)) = f (a, b ,c) (foldGraph f base (Graph nos as))

sumWeight :: (t, t, Int) -> Int -> Int
sumWeight (a, b, c) memo = c + memo

--Questão 3

--filterTree (<10) (Node 5 (Node 7 (Node 15 Nul (Node 6 Nul Nul)) (Node 2 Nul Nul)) (Node 10 Nul Nul)) 

data Tree t = Nul | Node t (Tree t) (Tree t) 
   deriving Show

filterTreeAux :: Tree t -> (t -> Bool) -> Tree t
filterTreeAux Nul f = Nul
filterTreeAux (Node x a b) f
   |f x = Node x (filterTreeAux a f) (filterTreeAux b f)
   |otherwise = Nul --consertar aqui
   
filterTree :: (t -> Bool) -> Tree t -> [Tree t]
filterTree f Nul = []
filterTree f (Node x a b)
   |f x = [filterTreeAux (Node x a b) f ]
   |otherwise = [filterTreeAux a f] ++ [filterTreeAux b f]


--Exercícios de sala
-- sumBiggerThen 8 [[2, 1, 4], [8, 5, 3], [1, 9, 3]]

sumBiggerThen :: Int -> [[Int]] -> [[Int]]
sumBiggerThen n lis = filter  (\x -> (foldr (+) 0 x) >= n ) lis

sumBiggerThenPred :: Int -> [[Int]] -> [[Int]]
sumBiggerThenPred n l = filter predic l
      where predic x = ((foldr (+) 0 x) >= n) --para um x qualquer

{- 
(f . g) x =  é uma função. 
g é aplicado primeiramente a x e dps f é aplicado a f(g x)
(.) :: (u -> v) -> (t -> u) -> (t -> v)

(.) f g x = f(g x)


OBS.:

*Main> (-10)
-10
*Main> (10-) 5
5
*Main> (-) 10 5
5
*Main> (\x ->10 - x) 5
5

-}

mapFilter :: (a -> Bool) -> [[a]] -> [[a]]
mapFilter f [] = []
mapFilter f l =  
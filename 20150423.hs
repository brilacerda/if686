import Data.List (sort)

--completude dos exercicios de sala

-- aula 01 - último slide
fibonnacci :: Int -> Int
fibonnacci 0 = 1
fibonnacci 1 = 1
fibonnacci a = fibonnacci (a-2) + fibonnacci (a-1)

isEven :: Int -> Bool
isEven i = (mod i 2 == 0)

listeFibonnacci :: Int -> [Int]
listeFibonnacci 0 = (1:[])
listeFibonnacci n =  (listeFibonnacci(n-1) ++ ((fibonnacci n) : []))

evenFibonnacciList :: Int -> [Int]
evenFibonnacciList 0 = []
evenFibonnacciList n = [l | l <- listeFibonnacci n, isEven l]

digitsSum :: Int -> Int
digitsSum 0 = 0
digitsSum n = mod n 10 + digitsSum (div (n- mod n 10) 10)

sortBy :: [Int] -> [Int]
sortBy [] = []
sortBy (a:as) = (sortBy [x | x <- as, (digitsSum x) < (digitsSum a)]) ++ [a] ++ (sortBy [x|x <- as, (digitsSum x) > (digitsSum a)])

-- Slide 03 - Último slide
--20150326.hs
countLetters :: [Char] -> Char -> Int
countLetters [] n = 0
countLetters (s:tr) n
   |s == n = 1 + countLetters tr n
   |otherwise = countLetters tr n

agrupar :: [[Char]] -> [(Char, Int)]
agrupar [[]] = []
agrupar str = (((head list), countLetters list (head list)) : agrupar [(filtra (head list) list)])
   where list = (foldr (++) [] str)

filtra ::  Char -> [Char] -> [Char]
filtra s str = [n|n <- str, n /= s]

-- Slide 04 - Último slide 

data Tree t = NulT | Node t (Tree t) (Tree t)
   deriving (Show)

--20150407.hs
-- Eu não sabia o que o collapse fazia, e como resolvi esses exercícios ja em casa tive que pergun Mas agora tá feito. 
-- teste: collapse (Node 5 (Node 8 (NulT) (NulT)) (Node 3 (Node 2 (NulT) (NulT)) (NulT)))

collapse :: Tree t -> [t]
collapse NulT = []
collapse (Node n left right) = (n : (collapse left)) ++ collapse right

--20150409.hs
--insertElement (Node 5 (Node 8 (NulT) (NulT)) (Node 3 (Node 2 (NulT) (NulT)) (NulT))) 7
insertElement :: Tree t -> t -> Tree t
insertElement NulT e = Node e  NulT NulT
insertElement (Node t left right) e = Node t (insertElement left e) right

--criarArvore [5, 8, 7, 3, 2] insertElement
criarArvore :: Ord t => [t] -> (Tree t -> t -> Tree t) -> Tree t
criarArvore list insertElement = foldr permuta NulT list

permuta :: t -> Tree t -> Tree t 
permuta = \n tree -> insertElement tree n

igual :: Eq t => [t] -> t -> Bool
igual [] n = False
igual (l:st) n
   |l == n = True
   |otherwise = igual st n

   --Slide 05 #20

joinElement :: Eq t => [t] -> t -> Bool
joinElement list n = length ([l|l <- list, l == n]) >= 1

inter :: Eq t => [t] -> [t] -> [t]
inter [] _ = []
inter _ [] = []
inter l1 (l:st) 
   |joinElement l1 l = (l: inter l1 st)
   |otherwise = inter l1 st

removeSet :: Eq t => [t] -> t -> [t]
removeSet list n = [l|l <- list, not (n == l)]

diff :: Eq t => [t] -> [t] -> [t]
diff a [] = a
diff [] _ = []
diff a (b:bs) = diff (removeSet a b) bs
 
mapfilter :: (Ord t) => [t] -> (t-> t) -> (t -> Bool) ->  [t]
mapfilter list f g = [f e |e <- [n|n <- list, g n]]

set :: Eq t => [[t]] -> [t]
set list = foldr (++) [] list

--map.foldr
f :: Bool -> Int -> Int
f True x = x + 10
f _ x = x - 10

mapfold :: (a -> b -> b) -> [b] -> [[a] -> b]
mapfold _ [] = []
mapfold f (b:bs) = (f' f b) : (mapfold f bs)
	where
		f' f b [] = b
		f' f b (a:as) = f' f (f a b) as
--f' :: (a -> b -> b) -> b -> [a] -> b

--applyMapFold :: [[a] -> b] -> [b]

--slide 6 #3

--Questão 2

data Graph = Graph [Int] [(Int, Int, Int)]

--buscarNo (Graph [1, 2, 3] [(1, 2, 5), (2, 3, 2), (3, 1, 3)]) 2

buscarNo :: Graph -> Int -> [(Int, Int)] --retorna lista de (peso, nó adj) ordenada
buscarNo (Graph _ []) _ = []
buscarNo (Graph nos ((x,y,p):adjs)) n
   |x == n = sort ((p, y) : buscarNo (Graph nos adjs) n)
   |y == n = sort ((p, x) : buscarNo (Graph nos adjs) n)
   |otherwise = sort (buscarNo (Graph nos adjs) n)

pegaPeso :: [(Int, Int)] -> Int
pegaPeso list = fst (head(list))

pegaAdjMenor :: [(Int, Int)] -> Int
pegaAdjMenor list = snd (head(list))

--marca simplesmente exclui aquele nó da lista de nós do grafo
--marca :: Graph -> Int -> Graph
--marca graph no = 
{-
geraMenorCaminhoAux :: Graph -> [[(Int, Int)]] -> Int -> Int -> Int
geraMenorCaminhoAux 
-}
--function not finished properly
geraMenorCaminho :: Graph -> Int -> Int -> Int
geraMenorCaminho (Graph [] []) _ _ = 0
geraMenorCaminho (Graph nos adj) ini fim 
   |ini == fim = 0
   |pegaAdjMenor (buscarNo (Graph nos adj) ini) == fim = 0
   |otherwise = pegaPeso (buscarNo (Graph nos adj) ini) 
   + (geraMenorCaminho (Graph nos adj) (pegaAdjMenor (buscarNo (Graph nos adj) ini)) fim)

-- Anotações de aula
{-
iter 10 ((*)2) 3 == 1024*3 
iter 10 (2 (*)) 3 == ERRO
iter 10 (2 *) 3 == 1024*3
iter 10 (*2) 3 == 3*1024
iter 10 (/2) 2000 == 2000/1024
iter 1 ((/) 2) 2000 == 2/2000
iter 2 ((/) 2) 2000 == 2/(2/2000) == 2000
iter 3 ((/) 2) 2000 == 2/(2/(2/2000)) == 2/2000
-}
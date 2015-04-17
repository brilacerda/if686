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
--fnw
removeRepetition :: Eq t => [t] -> t -> [t]
removeRepetition [] _ = []
removeRepetition list n = foldr (/= n) [] list

inter :: Eq t => [t] -> [t] -> [t]
inter l1 (l:st) = [n | n <- l1, igual l1 l] ++ igual l1 st
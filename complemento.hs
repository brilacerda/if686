data Tree t = NulT | Node t (Tree t) (Tree t)
   deriving (Show)

--20150407.hs
-- Eu não sabia o que o collapse fazia, e como resolvi esses exercícios ja em casa tive que pergun Mas agora tá feito. 

-- teste: collapse (Node 5 (Node 8 (NulT) (NulT)) (NulT)) (Node 3 (Node 2 (NulT) (NulT)))

collapse :: Tree t -> [t]
collapse NulT = []
collapse (Node n left right) = (n : (collapse left)) ++ collapse right

--20150409.hs

insertElement :: Tree t -> t -> Tree t
insertElement NulT e = Node e  NulT NulT
insertElement (Node t left right) e = Node t (insertElement left e) right
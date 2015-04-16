-- Trabalho 8
import Data.List (sort)

filterNSave :: (Ord t) => [t] -> [t] -> [[t]]
filterNSave [] _ = []
filterNSave l [] = [l]
filterNSave list (a:as) = ((filter ( <= a) list) : (filterNSave (filter ( > a) list) as))

listPartitioner :: (Ord t, Num t) => [t] -> ([t] -> [[t]])
listPartitioner list = \list2 -> filterNSave list2 (sort list)

--função lambda pode ter mais de um parâmetro e eles são separados por espaço
--todas as funções decladas em Haskell viram variáveis que são definidas em lambdas (com apenas um parâmetro. Várias com um parâmetro cada)
-- (.) f g = \x -> g (f x)

--exercicio primeiro da aula que está requisitando a função
-- f, porém a mesma não está definida, logo está comentada

--lambda = \b a -> f a b

--usando fst E SEM USAR LAMBDA
primeiros :: [(t, u)] -> [t]
primeiros [] = []
primeiros (l:ls) = (fst l : primeiros ls)

--usando casamento de padrões E SEM USAR LAMBDA
primeirosCP :: [(t, u)] -> [t]
primeirosCP [] = []
primeirosCP ((a, b):as) = (a : primeiros as)

prim :: [(t, u)] -> [t]
prim list = map (\(v, w) -> v) list

lengthBiggerThan :: [[Int]] -> Int -> [[Int]]
lengthBiggerThan list n = filter (\l -> ((length l) > n )) list

--union = \lis 

-- set :: [[Int]] -> [Int]
-- set list = \n m = [e | e <- sort (foldr (++) [] list), ]

sumCte :: Int -> [Int] -> [Int]
sumCte x list = map (+x) list

greater :: [Int] -> Int
greater 
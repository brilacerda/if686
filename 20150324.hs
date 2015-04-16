-- quicksort
getMinor :: Int -> [Int] -> [Int]
getMinor x [] = []
getMinor x (l:ls)
   |(x > l) = l : (getMinor x ls)
   |otherwise = getMinor x ls
   
getMajor :: Int -> [Int]-> [Int]
getMajor x [] = []
getMajor x (l:ls)
   |(x <= l) = l : (getMajor x ls)
   |otherwise = getMajor x ls
   
quickS :: [Int] -> [Int]
quickS [] = []
quickS (l:ls) = quickS (getMinor l ls) ++ (l:[]) ++ quickS (getMajor l ls)

-- Trabalho 2
-- mergesort

divide :: [Int] -> ([Int],[Int])
divide [] = ([],[])
divide (a:[]) = ([a],[]) 
divide (a:b:as) = (a:fst (divide as), b:snd (divide as))

sort :: [Int] -> [Int]
sort [] = []
sort (l:[]) = [l]
sort l = merge (sort (fst (divide l))) (sort (snd (divide l)))

merge :: [Int] -> [Int] -> [Int]
merge [] [] = [] 
merge a [] = a
merge [] b = b
merge a b 
    |head a < head b = head a : (merge(tail a) b)
    |head a >= head b = head b : (merge a (tail b))

-- heapsort
len :: [Int] -> Int
len [] = 0
len l  = 1 + len (tail l)

findEl :: [Int] -> Int -> Int
findEl [] _ = -2000000000000000000
findEl l  1 = head l
findEl l n  = findEl (tail l) (n-1)


findElPermuta :: [Int] -> Int -> ([Int],[Int])
findElPermuta [] _ = ([],[])
findElPermuta l  1 = ([], tail l)
findElPermuta l n  = (head l : fst (findElPermuta (tail l) (n-1)), [] ++ snd (findElPermuta (tail l) (n-1)))

permuta :: [Int] -> Int -> Int -> [Int]
permuta [] _ _           = []
permuta l 1 j
             | j > len l = l
	     | j == 1    = l
             | otherwise = (findEl l j) : fst(findElPermuta (tail l) (j -1)) ++ [head l] ++ snd (findElPermuta (tail l) (j-1))
permuta l i j
             | i == j    = l
	     | otherwise = head l : permuta (tail l) (i-1) (j-1)


heapfy :: [Int] -> Int -> [Int]
heapfy [] _ = []
heapfy l  i | ((findEl l  (2*i)      > findEl l (i)) && (findEl l  (2*i)      > findEl l ((2*i) + 1))) = heapfy ((permuta l i  (2*i)))       (2*i)
	    | ((findEl l ((2*i) + 1) > findEl l (i)) && (findEl l ((2*i) + 1) > findEl l  (2*i)))      = heapfy ((permuta l i ((2*i) + 1))) ((2*i) + 1)
            |  (findEl l  (2*i)      > findEl l (i))                                                   = heapfy ((permuta l i  (2*i)))       (2*i)
	    |  (findEl l ((2*i) + 1) > findEl l (i))                                                   = heapfy ((permuta l i ((2*i) + 1))) ((2*i) + 1)
	    | otherwise = l


buildMaxHeap :: [Int] -> Int -> [Int]
buildMaxHeap [] _ = []
buildMaxHeap l  1 = heapfy l 1
buildMaxHeap l  i = buildMaxHeap(heapfy l i) (i-1)

heapSort :: [Int] -> [Int]
heapSort []     = []
heapSort (a:[]) = [a]
heapSort l  =  heapSort(tail (buildMaxHeap l (len l))) ++ [head (buildMaxHeap l (len l))]

-- Exercicios de aula

getMax :: Int -> Int -> Int
getMax a b
   |a > b = a
   |b > a = b

getMin :: Int -> Int -> Int
getMin a b
   |a > b = b
   |b > a = a

getMedium :: Int -> Int -> Int -> Int
getMedium a b c = a + b + c - (getMax (getMax a b) c) - (getMin (getMin a b) c)

menorMaior :: Int -> Int -> Int -> (Int, Int)
menorMaior a b c = ( (getMax (getMax a b) c) , (getMin (getMin a b) c))
   
ordenaTripla :: (Int, Int, Int) -> (Int, Int, Int)
ordenaTripla (a, b, c) = ((getMin (getMin a b) c), getMedium a b c , (getMax (getMax a b) c))

type Ponto = (Float, Float)
type Reta = (Ponto, Ponto)

firstCoor :: Ponto -> Float
firstCoor (a, b) = a

sndCoor :: Ponto -> Float
sndCoor (a, b) = b

isUpright :: Reta -> Bool
isUpright ((a, b), (c,d)) 
   |a == c = True
   |otherwise = False

--biblioteca
type Pessoa = String
type Livro = String
type BancoDados = [(Pessoa, Livro)]

baseExemplo :: BancoDados
baseExemplo = 
 [("Sergio","O Senhor dos Aneis"),
 ("Andre","Duna"),
 ("Fernando","Jonathan Strange & Mr. Norrell"), 
 ("Fernando","The Game of Thrones")]

livros :: BancoDados -> Pessoa -> [Livro]
livros [] ps = []
livros ((p,l):bd) ps
   |p == ps = l : (livros bd ps)
   |otherwise = livros bd ps

emprestimo :: BancoDados -> Livro -> [Pessoa]
emprestimo [] liv = []
emprestimo ((p,l):bd) liv
   |l == liv = p : (emprestimo bd liv)
   |otherwise = (emprestimo bd liv)

emprestado :: BancoDados -> Livro -> Bool
emprestado [] liv = False
emprestado ((p,l):bd) liv
   |l == liv = True
   |otherwise = emprestado bd liv

qtdEmprestimos :: BancoDados -> Pessoa -> Int
qtdEmprestimos bd ppl
  |bd == [] = 0
  |fst(head bd) == ppl = (qtdEmprestimos (tail bd) ppl) +1
  |otherwise = qtdEmprestimos (tail bd) ppl

emprestar :: BancoDados -> Pessoa -> Livro ->  BancoDados
emprestar bd p l 
   |p == "" || l == "" = bd
   |otherwise = (p,l):bd

devolver :: BancoDados -> Pessoa -> Livro ->  BancoDados
devolver ((p,l):bd) pp liv
  |l == "" = (p,l) : devolver bd pp liv
  |p == "" = (p,l) : devolver bd pp liv
  |p == pp && l == liv = bd
  |otherwise = (p,l) : devolver bd pp liv

membro :: [Int] -> Int -> Bool
membro lis n = (length[x|x <- lis, x == n]) > 0

livros2 :: BancoDados -> Pessoa -> [Livro]
livros2 bd ppl = [l|(p, l) <- bd, ppl == p]

emprestimos2 :: BancoDados -> Livro -> [Pessoa]
emprestimos2 bd liv = [p|(p,l) <- bd, l == liv]

emprestado2 :: BancoDados -> Livro -> Bool
emprestado2 bd liv = (length[p|(p,l) <- bd, l == liv]) > 0

qtdEmprestimos2 :: BancoDados -> Pessoa -> Int
qtdEmprestimos2 bd ps = length[l|(p,l)<-bd, p==ps]

devolver2 :: BancoDados -> Pessoa -> Livro -> BancoDados
devolver2 bd ps liv = [(p,l)|(p,l) <- bd, p/=ps && l /= liv]

-- Quicksort usando compressão de lista
qsortCL :: [Int] -> [Int]
qsortCL [] = []
qsortCL (a:as) = (qsort [x | x <- as, x < a]) ++ [a] ++ (qsort [x | x <- as, x >= a])

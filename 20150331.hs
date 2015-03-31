-- Trabalho 4

--2 

--look and say onde n é o n-ésimo valor da sequência e x é o valor inicial do look n say iterator que é 0 e dps fica a cargo da recursão
lookNsay :: Int -> Int -> Int
lookNsay 0 x = x
lookNsay n x = lookNsay (n-1) (lookNsayIterator x)

lookNsayIterator :: Int -> Int
lookNsayIterator 0 = 1
lookNsayIterator n = passaPraInt (lookNsaySeq(emLista n))

lookNsaySeq :: [Int] -> [Int]
lookNsaySeq [] = []
lookNsaySeq inn = (length inn - length (cardinal inn (head inn)))*10 + head inn : lookNsaySeq (cardinal inn (head inn))

--lookNsaySeq n = ((length (emLista n) - length(cardinal (emLista n) (head (emLista n))))*10 + (head (emLista n)) : (cardinal (emLista n) (head (emLista n)))
--lookNsaySeq n = ((cardinal (emLista n) (head (emLista n)))*10 + (head (emLista n))) : lookNsaySeq ((cardinal (emLista n) (head (emLista n))))

passaPraInt :: [Int] -> Int
passaPraInt [] = 0
passaPraInt ls = mult ((length ls)-1) (head ls) + passaPraInt (tail ls)

mult :: Int -> Int -> Int
mult factor num
   |factor <= 0 = num
   |otherwise = mult (factor-1) (num*100)

cardinal :: [Int] -> Int -> [Int]
cardinal [] x = []
cardinal  inn x
   |(head inn) /= x = inn
   |otherwise = (cardinal (tail inn) x)

emLista :: Int -> [Int]
emLista 0 = []
emLista n = emLista (reduzNum n) ++ (mod n 10 : [])

--reduz o número da direita pra esquerda pra poder colocar na lista
reduzNum :: Int -> Int
reduzNum n = div (n - mod n 10) 10

-- Questao 4

--[[1,2,3],[4,5,6],[7,8,9]]

qsort :: [Int] -> [Int]
qsort (a:as) = [x | x <- as, x<a] ++ [a] ++ [x | x<- as, x>=a]

--l == tamanho da lista,  m == contador
getMediana :: [Int] -> Int -> Int -> Int
getMediana [] l m  = 0
getMediana (a:as) l m 
   |(mod l 2) == 0 && (m == (div l 2)) = a + getMediana as l (m+1)
   |not ((mod l 2) == 0) && ((m == (div l 2)) || (m == ((div l 2)+1))) = div (a + getMediana as l (m+1)) 2 
   |otherwise = getMediana as l (m+1)

-- deixa tudo em uma só lista
conca :: [[Int]] -> [Int]
conca [] = []
conca (l:ls) = l ++ conca ls

-- formula ((x-1)*n + y - 1) == anda uma linha + y(colunas) -1(por que o 1,1 nao entrava)
getIndex :: [Int] -> Int -> Int -> Int -> Int -> Int
getIndex ls cont x y n
   |x > n || y > n = 0
   |cont == ((x-1)*n + y - 1) = (head ls)
   |((x-1)*n + y) > n*n = 0
   |otherwise = getIndex (tail ls) (cont + 1) x y n

-- simplesmente pega os vizinhos pelo index
getVizinhosX :: [Int] -> Int -> Int -> Int -> [Int]
getVizinhosX [] x y n = []
getVizinhosX ls x y 0 = []
getVizinhosX ls x y n = ((getIndex ls 0 x y n) : (getVizinhosX ls 0 (x+n-1) y n))

getVizinhosY :: [Int] -> Int -> Int -> Int -> [Int]
getVizinhosY [] x y n = []
getVizinhosY ls x y 0 = []
getVizinhosY ls x y n = ((getIndex ls 0 x y n) : (getVizinhosY ls 0 x (y+n-1) n))

putTogether :: [[Int]] -> Int -> Int -> Int -> Int
putTogether ls n x y = getMediana (qsort (((getVizinhosX (conca ls) 0 x y n) ++ (getVizinhosY (conca ls) 0 x y n))) (length ls) 0)

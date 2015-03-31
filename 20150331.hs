-- Trabalho 4

-- Questao 1 
-- Em Haskell a função de declaração é imutável, diferente de Java o qual é possível definir diferentes funções com o mesmo nome e parâmetros diferentes
-- Enquanto Java aponta erros em tempo de execução e permite que mais erros ocorram por ser mais geral e não restrigir o tipo de dados, Haskell aponta erros em tempo de compilação,
-- dando erro em generics dependendo da operação que é feita junto com o tipo de dados utilizado.

-- Questao 2 

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

-- Questao 3

type Rotulo = Int
type No = (Rotulo, [Rotulo])
type Grafo = [No]
type Arestas = (Rotulo, Rotulo)

searchRotulo :: [Rotulo] -> Rotulo -> Bool
searchRotulo [] b = False
searchRotulo (a:as) b | a == b = True
	|otherwise =  searchRotulo as b 

search :: Grafo -> Rotulo -> Rotulo ->[Arestas]
search [] r1 r2 =  []
search y@((a, (b:bs)):xs) r1 r2 | (a == r1) && (r1 /= r2) = if searchRotulo (b:bs) r2 then
																 [(a, r2)]
															else				
																(a,b) : search y b r2 
	| r1 == r2 = search [] r1 r2
	|r1 /= a = search xs r1 r2

-- Questao 4

--[[1,2,3],[4,5,6],[7,8,9]]

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
getVizinhosX :: [Int] -> Int -> Int -> Int -> Int -> [Int]
getVizinhosX ls x y n t
   |ls == [] = []
   |n <= 0 = []
   |otherwise = ((getIndex ls 0 x y t) : (getVizinhosX ls (x+n-1) y (n-1) t))

getVizinhosY :: [Int] -> Int -> Int-> Int -> Int -> [Int]
getVizinhosY ls x y n t
   |ls == [] = []
   |n <= 0 = []
   |otherwise = ((getIndex ls 0 x y t) : (getVizinhosY ls (x+1) (y+n-1) (n-1)) t)

putTogether :: [[Int]] -> Int -> Int -> Int -> Int
putTogether ls n x y = getMediana (qsort (getVizinhoS (conca ls) x y n) )  (length ls) 0

getVizinhoS :: [Int] -> Int -> Int -> Int -> [Int]
getVizinhoS ls n x y = (getVizinhosX ls (x+n-1) y (n-1) n) ++ (getVizinhosY ls x (y+n-1) (n-1) n)

qsort :: [Int] -> [Int]
qsort (a:as) = [x | x <- as, x<a] ++ [a] ++ [x | x<- as, x>=a]

-- Exercicios

-- 1
afd :: [Char] -> [Int] -> [(Int, Int, Char)] -> Int -> [Int] -> Bool
afd str q ((a, b, c):as) qi f
   |

estadoPertence :: 
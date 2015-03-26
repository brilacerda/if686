--Trabalho 3
--Questao 1
type Hash = [(Int, Int)]

get :: Hash -> Int -> Int
get ((k, v):hs) key
   |k == key = v
   |otherwise = get hs key

put :: Hash -> Int -> Int -> Hash
put hs k v = 
   if hasKey hs k == False
   then hs ++ (k , v):[]
   else hs

remove :: Hash -> Int -> Hash
remove hs key = [(k, v)|(k, v)<-hs, k /= key]

hasKey :: Hash -> Int -> Bool
hasKey hs key = length ([v|(k, v)<- hs, k == key]) > 0

--Questao 2

comparaConjuntos :: (Eq t) => [t] -> [t] -> String
comparaConjuntos a b 
   |(length([x|x<-a, algum b x]) == (length a)) && (length([x|x<-b, algum a x]) == length b)  = "A igual a B"
   |length([x|x<-a, algum b x]) == 0 = "Conjuntos disjuntos"
   |length([x|x<-a, algum b x]) == length b = "A contem B"
   |length([x|x<-b, algum a x]) == length a = "B contem A"
   |length([x|x<-a, algum b x]) < length a = "A interseciona B"
   
algum :: (Eq t) => [t] -> t -> Bool
algum b x = length ([y|y<-b, x==y]) > 0

--Exercicios
takeN :: [t] -> Int -> [t]
takeN [] _ = []
takeN l 0 = []
takeN (l:ls) n = l : takeN ls (n-1)

dropN :: [t] -> Int -> [t]
dropN [] _ = []
dropN (l:ls) 0  = l : dropN ls 0
dropN (l:ls) n = dropN ls (n-1)

bigger10 :: Int -> Bool
bigger10 x = x > 10

takeWhileX :: (t -> Bool) -> [t] -> [t]
takeWhileX _ [] = []
takeWhileX f (l:ls)  
   |f l = l : takeWhileX f ls
   |not (f l) = takeWhileX f []

type Hash = [(Int, Int)]

get :: Hash -> Int -> Int
get ((k, v):hs) key
   |k == key = v
   |otherwise = get hs key

--caso nao interesse se a chave for repetida
put :: Hash -> Int -> Int -> Hash
put hs k v = hs ++ (k , v):[]

--caso nao possa chave repetida
put2 :: Hash -> Int -> Int -> Hash
put2 hs k v = 
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
   |length([x|x<-a, algum b x]) == length a = "A contem B"
   |length([x|x<-b, algum a x]) == length b = "B contem A"
   |length([x|x<-a, algum b x]) < length a = "A interseciona B"
   
algum :: (Eq t) => [t] -> t -> Bool
algum b x = length ([y|y<-b, x==y]) > 0
type Hash = [(Int, Int)]

-- get :: Hash -> Int -> Int
-- get [] key = -1
--get hs key 
   

put :: Hash -> Int -> Int -> Hash
put hs k v = hs ++ (k , v):[]


compara :: (Eq t) => [t] -> [t] -> String
compara a b 
   |(length([x|x<-a, algum b x]) == (length a)) && (length([x|x<-b, algum a x]) == length b)  = "A igual a B"
   |length([x|x<-a, algum b x]) == 0 = "Conjuntos disjuntos"
   |length([x|x<-a, algum b x]) == length a = "A contem B"
   |length([x|x<-b, algum a x]) == length b = "B contem A"
   |length([x|x<-a, algum b x]) < length a = "A interseciona B"
   
algum :: (Eq t) => [t] -> t -> Bool
algum b x = length ([y|y<-b, x==y]) > 0
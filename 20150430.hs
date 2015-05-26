{- ANOTAÇÕES DE AULA

>>= Junta computações monadicas

Em contexto de maybe:

applyMaybe ou (>>=) operador de bind retira o contexto
(>>= ) (Just 3) f = f 3

(>>=) (Nothing) _ = Nothing

return adiciona um contexto mínimo
return 3 = Just 3

----------------------------------------
return 33 >>= \x -> safeDiv 10000 x 
>>= (\y->return $ show y) >>= safeTail

equivale a

do {
	x <- return 33; // <- retira o contexto (é necessário ter um valor do tipo Maybe, se usar só 33, dá erro de tipos)
	y <- safeDiv 10000 x;  //se x for nothing nada é passado(por parâmetro como no lambda) pra y, pois nenhuma função é chamada
	z <- return $ show y;
	safeTail z;
}

-}


data Failable t = Correct t | Error String
   deriving Show

instance Monad Failable where
   (>>=) (Correct n) f = f n
   (>>=) (Error str) _ = Error str
   return n = Correct n

data Stack t = Fila Int [t] | Empty Int
   deriving Show

criarFila :: (Show t) => Int -> t -> Failable (t, Stack t)
criarFila n first 
   |n <= 0 = Error "Out of Capacity"
   |n > 0 = Correct (first, Fila (n-1) [first])


--push 3 (Fila (-1) [3,0,4,6])

push :: (Show t) => t -> Stack t -> Failable (t, Stack t)
push elmto (Empty cap) = criarFila cap elmto
push elmto (Fila cap fila) 
   |cap > 0  = Correct (elmto, Fila (cap-1) (elmto:fila))
   |cap <= 0 = Error "Out of Capacity"


--pop (Fila 2 [9, 4, 6])

pop :: Stack t -> Failable (t, Stack t)
pop (Empty cap) = Error "Empty stack"
pop (Fila cap (f:fs)) = Correct (f, Fila (cap+1) fs)


--peek (Empty 1)
--peek (Fila 2 [0,3,4,6])

peek :: Stack t -> Failable (t, Stack t)
peek (Empty cap) = Error "There is no element on the stack"
peek (Fila cap (f:fs)) = Correct (f, Fila cap (f:fs))
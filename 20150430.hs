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

data Fila t = First t | Rest [t]
   deriving Show

criarFila :: (Show t) => Int -> t -> Failable (t, Fila t)
criarFila n first 
   |n <= 0 = Error "Out of Capacity"
   |n > 0 = Correct (first, First first)



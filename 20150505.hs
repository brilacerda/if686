{-
-- Código em LUA

function f ()
   local i = 0
     return function ()
        i = i + 1
        return i
     end
end

g = f()
g () = 1
g () = 2

h = f()
h () = 1
h () = 2

A função mais interna vai em um escopo mais externo pra localizar a variável 
que está sendo usado na função interna e cria uma cópia dessa, logo quando é
chamado novamente ele usa essa cópia com o valor salvo na memória e aplica a
função interna, nesse caso, iterando.
-}

import Data.Char

--Questão 1

{-

data Hash = Elem [(Int, Int)] | Empty

--hasKey (Elem [(2, 3), (1, 8)]) 3
hasKey :: Hash -> Int -> Maybe Bool
hasKey Empty _ = Nothing
hasKey (Elem (h:hs)) key = do {
   if (fst h) == key 
    then Just True
    else if hs == []
      then hasKey Empty key
      else hasKey (Elem hs) key
}
-}

type Hash t u = [(t, u)]

--hash base
hash :: Hash Int Int
hash = [(2, 3), (1, 8)]

hasKey :: Eq t => Hash t u  -> t -> Bool
hasKey hs key = length ([v|(k, v)<- hs, k == key]) > 0

remove :: (Eq t) => Hash t u -> t -> Maybe (Hash t u)
remove [] _ = Nothing
remove (h:hs) key 
   |not (hasKey (h:hs) key) = Just (h:hs)
   |otherwise = if (fst h) == key 
    then remove hs key --para cobrir o caso de uma tupla e ela ser excluída
    else remove (hs ++ [h]) key

get :: (Eq t) => Hash t u -> t-> Maybe (t, u)
get [] _ = Nothing
get (h:hs) key
   |(fst h) == key = Just h
   |otherwise = get hs key

put :: (Eq t) => Hash t u -> (t, u) -> Maybe (Hash t u)
put hs (k, v)
   |hasKey hs k = Nothing
   |otherwise = Just ((k, v):hs)

{- Não sei pq não funciona

main' :: Hash t v
main' = do {
  a <- put hash (0,9);
  b <- put a (6,3);
  c <- remove b 2;
  d <- put c (20, 1);
  e <- put d (7, 4);
  f <- remove e 1;
  g <- put f (2,0);
  h <- put g (12, 6);
  i <- remove h 0;
  j <- put i (0, 1);
  k <- put j (29, 2);
  l <- remove k 20;
  m <- put l (22, 2);
  n <- put m (26, 3);
  return n
}

-}

--Questão 2

isPonctuation :: Char -> Bool
isPonctuation c 
   |(32 < (ord c) && (ord c) < 65) || (90 < (ord c) && (ord c) < 97) || (122 < (ord c) && (ord c) < 127) = True
   |otherwise = False

hasPonctuation :: String -> Bool
hasPonctuation [] = False
hasPonctuation (s:tr)
   |isPonctuation s = True
   |otherwise = hasPonctuation tr

verifica :: String -> String -> Maybe String
verifica [] dados = Just (dados)
verifica (s:tr) dados
   |hasPonctuation (s:tr) = Nothing
   |(96 < (ord s)) &&  ((ord s) < 123) = verifica tr ((toUpper s):dados) --é minuscula
   |(64 < (ord s)) && ((ord s) < 91) = verifica tr (s:dados) -- é maiúscula
   |((ord s) == 32) = verifica tr (('\n'):dados) -- espaço
   --s ==  Just (reverse dados) --caso seja enter emprima

f :: Maybe String -> IO ()
f Nothing = putStrLn "Nothing"
f (Just []) = putStr ""
f (Just str) = putStrLn str

main :: IO ()
main = do {
    str <- getLine;
    var <- f (verifica str []);
    return var;
    --putStrLn str;
    main
}

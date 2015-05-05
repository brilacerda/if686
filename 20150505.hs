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

--Questão 2
import Data.Char

verifica :: String -> String
verifica [] = []
verifica (s:tr)
   |96 < (ord s) &&  (ord s) < 123 = ((toUpper s): (verifica tr)) --é minuscula
   |64 < (ord s) && (ord s) < 91 = (s : (verifica tr)) -- é maiúscula
   |(ord s) == 32 = ('\n' : (verifica tr)) -- espaço
   |otherwise = "Nothing"

main :: IO ()
main = do {
    str <- getLine;
    putStrLn (verifica str);
    --putStrLn imprime;
    main
}

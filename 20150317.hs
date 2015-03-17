vendas :: Int -> Int
vendas x 
    |x == 0 = 2
    |otherwise = x

vendasIguais :: Int -> Int -> Int
vendasIguais s n = 
    if n == 0 
    then 
        if vendas 0 == s
		then 1
		else 0
    else 
        if vendas n == s
        then (vendasIguais s (n-1) + 1)
        else vendasIguais s (n-1)

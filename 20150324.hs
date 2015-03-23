getMinor :: Int -> [Int] -> [Int]
getMinor x [] = []
getMinor x (l:ls)
   |(x > l) = l : (getMinor x ls)
   |otherwise = getMinor x ls
   
getMajor :: Int -> [Int]-> [Int]
getMajor x [] = []
getMajor x (l:ls)
   |(x <= l) = l : (getMajor x ls)
   |otherwise = getMajor x ls
   
quickS :: [Int] -> [Int]
quickS [] = []
quickS (l:ls) = quickS (getMinor l ls) ++ (l:[]) ++ quickS (getMajor l ls)

-- merge & cia

divide :: [Int] -> ([Int],[Int])
divide [] = ([],[])
divide (a:[]) = ([a],[]) 
divide (a:b:as) = (a:fst (divide as), b:snd (divide as))

sort :: [Int] -> [Int]
sort [] = []
sort (l:[]) = [l]
sort l = merge (sort (fst (divide l))) (sort (snd (divide l)))

merge :: [Int] -> [Int] -> [Int]
merge [] [] = [] 
merge a [] = a
merge [] b = b
merge a b 
    |head a < head b = head a : (merge(tail a) b)
    |head a >= head b = head b : (merge a (tail b))

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
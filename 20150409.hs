data Nodes t = Node Float t [(Nodes t)] 
   deriving (Eq, Show)

data DirectedGraph t = DirectedGraph [(Nodes t)]
   deriving (Eq, Show)
   
findDFS :: DirectedGraph t -> t -> Bool
findDFS [] = False
findDFS (Node peso valor ((Node p n []):graph) ) v 
   |valor == n || valor == v = True
   |otherwise = findDFS graph v

findDFS (Node peso valor graph) v 
   |valor == v = True
   |otherwise = findDFS (head graph) v -- não folha

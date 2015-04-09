data Node t = Node Float t [Node t] 
   deriving (Eq, Show)

data DirectedGraph t = [(Node t)]
   deriving (Eq, Show)
   
findDFS :: DirectedGraph t -> t -> Bool
findDFS [] = False
findDFS (Branch peso valor ((Node p v []):graph)) v 
   |valor == v = True
   |otherwise findDFS graph v
findDFS (Branch peso valor graph) v 
   |valor == v = True
   |otherwise = findDFS (head graph) v -- não folha

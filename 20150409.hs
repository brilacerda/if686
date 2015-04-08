data Node t = Float t
   deriving (Eq, Show)

data DirectedGraph t = Leaf (Node t) | Node t [Node t]
   deriving (Eq, Show)
   
findDFS :: DirectedGraph t -> Bool

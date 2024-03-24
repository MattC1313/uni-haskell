data IntList = Empty | Cons Int IntList deriving(Show)

data Tree = Leaf | Branch Tree Tree deriving (Show)

data DTree a = DLeaf a
             | DBranch a (DTree a) (DTree a)
                                deriving (Show)
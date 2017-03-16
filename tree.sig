sig tree.
accum_sig tuple, lists.

kind tree   (type -> type -> type).
type empty  (tree A B).
type branch (A -> B -> tree A B -> tree A B -> tree A B).

type singleton     (A -> B -> tree A B -> o).
type insert        (A -> B -> tree A B -> tree A B -> o).
type insertBy      ((B -> B -> B -> o) -> A -> B -> tree A B -> tree A B -> o).
type delete        (A -> tree A B -> tree A B -> o).
type lookup        (A -> tree A B -> B -> o).
type merge         (tree A B -> tree A B -> tree A B -> o).
type mergeBy       ((B -> B -> B -> o) -> tree A B -> tree A B -> tree A B -> o).
type list_to_tree  (list (tuple A B) -> tree A B -> o).
type tree_to_list  (tree A B -> list (tuple A B) -> o).

type foldTree      ((A -> B -> C -> C -> o) -> C -> tree A B -> C -> o).

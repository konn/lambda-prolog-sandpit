sig tuple.
kind   tuple    type -> type -> type.
type   pair     A    -> B    -> tuple A B.
infixr pair     90.

type pr1       tuple A B -> A -> o.
type pr2       tuple A B -> B -> o.
type map-tuple (A -> A') -> (B -> B') -> tuple A B -> tuple A' B' -> o.
type mapped-tuple
     ((A -> A' -> o) -> (B -> B' -> o) -> tuple A B -> tuple A' B' -> o).
type first     (A -> A') -> tuple A B -> tuple A' B -> o.
type second    (B -> B') -> tuple A B -> tuple A B' -> o.

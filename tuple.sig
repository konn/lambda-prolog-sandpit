sig tuple.
kind   tuple    type -> type -> type.
type   pair     A    -> B    -> tuple A B.
infixr pair     90.

exportdef pr1       tuple A B -> A -> o.
exportdef pr2       tuple A B -> B -> o.
exportdef map-tuple (A -> A') -> (B -> B') -> tuple A B -> tuple A' B' -> o.
exportdef
  mapped-tuple (A -> A' -> o) -> (B -> B' -> o) -> tuple A B -> tuple A' B' -> o.

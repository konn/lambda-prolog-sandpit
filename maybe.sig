sig maybe.
kind maybe    (type -> type).
type just     (A -> maybe A).
type nothing  maybe A.

type withDefault  (A -> maybe A -> A -> o).
type runMaybe     (A -> B -> o) -> B -> maybe A -> B -> o.
type sumMaybe     (A -> A -> A -> o) -> maybe A -> maybe A -> maybe A -> o.
type try          (A -> o) -> maybe A -> o.

% If there's no B with P A B, it returns nothing.
type map_maybe     (A -> B -> o) -> maybe A -> maybe B -> o.

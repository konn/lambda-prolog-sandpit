% Misc control structures.
sig control.
accum_sig lists.

type >>> (A -> o) -> (A -> B -> o) -> B -> o.
type @>  (B -> o) -> B -> o.
infixl >>> 120.
infixl @>  120.



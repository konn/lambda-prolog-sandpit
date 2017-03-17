sig simpl.

kind expr type.
type ++, --, **, //  (expr -> expr -> expr).
type ~~              (expr -> expr).
type app             (real -> real) -> expr -> expr.
type lit             real -> expr.
type var-x           expr.
infixl ++, --  150.
prefix ~~      155.
infixl **, //  160.

type reify      (real -> real) -> expr -> o.
type interpret  expr -> (real -> real) -> o.
type simplE     expr -> expr -> o.
type simpl      (real -> real) -> (real -> real) -> o.
type split (expr -> expr -> expr -> o) -> expr -> list expr -> o.

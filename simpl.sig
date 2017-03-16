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

exportdef reify      (real -> real) -> expr -> o.
exportdef interpret  expr -> (real -> real) -> o.
exportdef simplE     expr -> expr -> o.
exportdef simpl      (real -> real) -> (real -> real) -> o.
exportdef split (expr -> expr -> expr -> o) -> expr -> list expr -> o.

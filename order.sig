sig order.

% Ad-hoc parametric orders, done right.
% The below coincides with built-in order for ints and reals,
% but has better implementation for strings.
type   lt, gt, leq, geq  A -> A -> o.
infix  lt, gt, leq, geq  130.

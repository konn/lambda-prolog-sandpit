sig diff.

%% Automatic differentiation
% Deeply embedded automatic differentiation, without support for composition.
exportdef ediff ((real -> real) -> (real -> real) -> o).

% Deeply embedded automatic differentiation, with composition.
exportdef adiff ((real -> real) -> (real -> real) -> o).
exportdef ndiff int -> (real -> real) -> (real -> real) -> o.

exportdef simpl     (real -> real) -> (real -> real) -> o.
exportdef lim-0     (real -> real) -> real -> o.

%% Taylor expansion around the given point.
exportdef taylor     real -> (real -> real) -> stream real -> o.
exportdef maclaurin  (real -> real) -> stream real -> o.

%% Inifnite stream type.
kind stream type -> type.
type empty  (stream A).
type #      A -> cell (stream A) -> stream A.
infixr # 90.

% Smart constructor
type scons A -> (stream A -> o) -> stream A -> o.

% Returns the list cosisting of initial n values of the given stream
exportdef take     int -> stream A -> list A -> o.

% Drops initial n elements of the given stream.
exportdef drop     int -> stream A -> stream A -> o.

% Maps stream.
exportdef zipped (A -> B -> C -> o) -> stream A -> stream B -> stream C -> o.

% Cell containing a (possibly delayed) value.
kind cell  type -> type.
type thunk (A -> o) -> cell A.
type value A        -> cell A.

% Force cell to the value.
exportdef force  (cell A -> A -> o).

exportdef facts  stream int -> o.
exportdef machelper (real -> real) -> stream real -> o.
exportdef macTerm  int -> real -> real -> o.
exportdef facHelper int -> int -> stream int -> o.

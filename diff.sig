sig diff.

%% Automatic differentiation
% Deeply embedded automatic differentiation, without support for composition.
type ediff ((real -> real) -> (real -> real) -> o).

% Deeply embedded automatic differentiation, with composition.
type adiff ((real -> real) -> (real -> real) -> o).
type ndiff int -> (real -> real) -> (real -> real) -> o.

type simpl     (real -> real) -> (real -> real) -> o.
type lim-0     (real -> real) -> real -> o.

%% Taylor expansion around the given point.
type taylor     real -> (real -> real) -> stream real -> o.
type maclaurin  (real -> real) -> stream real -> o.

%% Inifnite stream type.
kind stream type -> type.
type empty  (stream A).
type #      A -> cell (stream A) -> stream A.
infixr # 90.

% Smart constructor
type scons A -> (stream A -> o) -> stream A -> o.

% Returns the list cosisting of initial n values of the given stream
type take     int -> stream A -> list A -> o.

% Drops initial n elements of the given stream.
type drop     int -> stream A -> stream A -> o.

% Maps stream.
type zipped (A -> B -> C -> o) -> stream A -> stream B -> stream C -> o.

% Cell containing a (possibly delayed) value.
kind cell  type -> type.
type thunk (A -> o) -> cell A.
type value A        -> cell A.

% Force cell to the value.
type force  (cell A -> A -> o).

type facts  stream int -> o.
type machelper (real -> real) -> stream real -> o.
type macTerm  int -> real -> real -> o.
type facHelper int -> int -> stream int -> o.

sig tutor.
% kind nat type.
% type z nat.
% type s nat -> nat.

% exportdef plus nat -> nat -> nat -> o.
% exportdef mult nat -> nat -> nat -> o.

exportdef odd  int -> o.
exportdef even int -> o.

% lists
kind list type -> type.
type null list A.
type   <> A -> list A -> list A.
infixr <> 9.

exportdef append list A -> list A -> list A -> o.
exportdef rev    list A -> list A -> o.

% difference lists
kind dlist type -> type.
type dl           (list A) -> (list A) -> (dlist A).
exportdef app-dl  (dlist A) -> dlist A -> dlist A -> o.

exportdef list2dlist list A  -> dlist A -> o.
exportdef dlist2list dlist A -> list A -> o.

% HOL
exportdef mapped (A -> B -> o) -> list A -> list B -> o.
exportdef forall (A -> o) -> list A -> o.

exportdef mapfun (A -> B) -> list A -> list B -> o.

% Difference List expressed inter
kind      flist      type -> type.
type      fl         (list A -> list A) -> flist A.
exportdef fcons      A       -> flist A -> flist A -> o.
exportdef app-fl     flist A -> flist A -> flist A -> o.
exportdef flist2list flist A -> list A  -> o.
exportdef list2flist  list A -> flist A -> o.

% Lazy Stream in λProlog
kind cell  type     -> type.   % Data-cell
type fcell A        -> cell A. % Forced cell
type dcell (A -> o) -> cell A. % Delayed cell (thunk).

kind stream    type -> type.
type empty     stream A.
type mk-stream A -> cell (stream A) -> stream A.

exportdef getcell   cell A -> A   -> o.
exportdef hd      stream A -> A -> o.
exportdef tl      stream A -> stream A -> o.
exportdef snil    stream A -> o.
exportdef scons   A -> (stream A -> o) -> stream A -> o.

exportdef step int -> int -> stream int -> o.
exportdef nats stream int -> o.
exportdef fib  int -> int -> stream int -> o.
exportdef take int -> stream A -> list A -> o.
exportdef search (A -> o) -> stream A -> A -> o.
exportdef filter (A -> o) -> stream A -> stream A -> o.
exportdef smapped (A -> B -> o) -> stream A -> stream B -> o.

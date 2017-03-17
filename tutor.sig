sig tutor.
% kind nat type.
% type z nat.
% type s nat -> nat.

% type plus nat -> nat -> nat -> o.
% type mult nat -> nat -> nat -> o.

type odd  int -> o.
type even int -> o.

% lists
kind list type -> type.
type null list A.
type   <> A -> list A -> list A.
infixr <> 9.

type append list A -> list A -> list A -> o.
type rev    list A -> list A -> o.

% difference lists
kind dlist type -> type.
type dl           (list A) -> (list A) -> (dlist A).
type app-dl  (dlist A) -> dlist A -> dlist A -> o.

type list2dlist list A  -> dlist A -> o.
type dlist2list dlist A -> list A -> o.

% HOL
type mapped (A -> B -> o) -> list A -> list B -> o.
type forall (A -> o) -> list A -> o.

type mapfun (A -> B) -> list A -> list B -> o.

% Difference List expressed inter
kind      flist      type -> type.
type      fl         (list A -> list A) -> flist A.
type fcons      A       -> flist A -> flist A -> o.
type app-fl     flist A -> flist A -> flist A -> o.
type flist2list flist A -> list A  -> o.
type list2flist  list A -> flist A -> o.

% Lazy Stream in λProlog
kind cell  type     -> type.   % Data-cell
type fcell A        -> cell A. % Forced cell
type dcell (A -> o) -> cell A. % Delayed cell (thunk).

kind stream    type -> type.
type empty     stream A.
type mk-stream A -> cell (stream A) -> stream A.

type getcell   cell A -> A   -> o.
type hd      stream A -> A -> o.
type tl      stream A -> stream A -> o.
type snil    stream A -> o.
type scons   A -> (stream A -> o) -> stream A -> o.

type step int -> int -> stream int -> o.
type nats stream int -> o.
type fib  int -> int -> stream int -> o.
type take int -> stream A -> list A -> o.
type search (A -> o) -> stream A -> A -> o.
type filter (A -> o) -> stream A -> stream A -> o.
type smapped (A -> B -> o) -> stream A -> stream B -> o.

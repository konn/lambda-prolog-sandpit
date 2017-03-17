module order.
import strings.

% Instances for ints.
(X : int) lt  (Y : int) :- X < Y.
(X : int) gt  (Y : int) :- X > Y.
(X : int) geq (Y : int) :- X >= Y.
(X : int) leq (Y : int) :- X <= Y.

% Instances for reals.
(X : real) lt  (Y : real) :- X < Y.
(X : real) gt  (Y : real) :- X > Y.
(X : real) geq (Y : real) :- X >= Y.
(X : real) leq (Y : real) :- X <= Y.

% Lexicographic ordering on lists, 
% derived from existing order on elements
nil       lt (X :: Xs).
(X :: Ys) lt (X :: Xs) :- Ys lt Xs.
(Y :: Ys) lt (X :: Xs) :- Y  lt X.

(Xs : list A) gt  Ys :- Ys lt Xs.

(Xs : list A) leq Xs.
(Xs : list A) leq Ys :- Xs lt Ys.

(Xs : list A) geq Ys :- Ys leq Xs.

% Ordering on string, done right.
(X : string) lt Y :-
  str_to_ints X Xs, str_to_ints Y Ys, Xs lt Ys.

(Xs : string) gt  Ys :- Ys lt Xs.

(Xs : string) leq Xs.
(Xs : string) leq Ys :- Xs lt Ys.

(Xs : string) geq Ys :- Ys leq Xs.

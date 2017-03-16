module tutor.
append null L L.
append (X <> L) M (X <> N) :- append L M N.

rev null null.
rev (X <> L) R :- rev L S, append S (X <> null) R.

odd N :- N < 0, !, M is 0 - N, odd M.
% odd -1.
odd 1.
odd N :- not (N is 0), M is N - 2, odd M.

even N :- not (odd N).

% even z.
% even (s (s X)) :- even X.

% difference list
app-dl (dl L R) (dl R S) (dl L S).

list2dlist L (dl R T) :- append L T R.
dlist2list (dl L nil) L.

% HOL

mapped P null null.
mapped P (X <> L) (Y :: K) :- P X Y, mapped P L K.

forall P null.
forall P (X <> L) :- P X, forall P L.

mapfun F null null.
mapfun F (X <> L) (F X <> M) :- mapfun F L M.

% fun-list

fcons A (fl F) (fl (tl \ (A <> F tl))).
app-fl (fl F) (fl G) (fl (tl \ F (G tl))).

flist2list (fl F) (F null).
list2flist null (fl (tl \ tl)).
list2flist (X <> L) (fl (tl \ X <> F tl)) :- list2flist L (fl F).

% Lazy Stream
hd (mk-stream V S) V.
tl (mk-stream V C) S :- getcell C S.

getcell (fcell V) V.
getcell (dcell F) V :- F V.

snil  empty.
scons X P (mk-stream X (dcell P)).

step X I T :- Y is X + I, scons X (S\ step Y I S) T.
nats S :- step 0 1 S.

fib X Y S :- Z is X + Y, scons X (T \ fib Y Z T) S.
take 0 S null.
take N S (X <> L) :-
  N > 0, M is N - 1, tl S TL, hd S X, take M TL L.

local mapcell (A -> B -> o) -> cell A -> cell B -> o.
mapcell P (fcell V) (fcell U) :- P U V.
mapcell P (dcell Q) (dcell (Y\ sigma X \ Q X, P X Y)).

smapped P empty empty.
smapped P (mk-stream X C) (mk-stream Y D) :- P X Y, mapcell (smapped P) C D.

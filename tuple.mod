module tuple.
pr1 (X pair Y) X.
pr2 (X pair Y) Y.

map-tuple F G (X pair Y) (X' pair Y') :-
  X' is F X, Y' is G Y.
mapped-tuple P Q (X pair Y) (X' pair Y') :- P X X', Q Y Y'.

first  F (A pair B) (A' pair B)  :- A' is F A.
second G (A pair B) (A  pair B') :- B' is G B.

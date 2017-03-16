module tuple.
pr1 (X pair Y) X.
pr2 (X pair Y) Y.

map-tuple F G (X pair Y) (F X pair G Y).
mapped-tuple P Q (X pair Y) (X' pair Y') :- P X X', Q Y Y'.

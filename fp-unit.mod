module fp-unit.
accumulate minifp.

typeof u unit.
value u.
eval u u.
eval (S then T) U :-
  eval S S', eval T T', eval ((lam V\ T') @ S') U.

typeof (S then T) V :- typeof S unit, typeof T V.
module strings.
accumulate lists.

chopstring S  (C :: Ss) :-
  N is (size S),
  N > 0, !,
  C  is substring S 0 1,
  M is (N - 1),
  S' is (substring S 1 M),
  chopstring S' Ss.
chopstring S [].

str_to_ints S Is :-
  chopstring S Cs,
  mapped (X\ Y\ Y is string_to_int X) Cs Is.
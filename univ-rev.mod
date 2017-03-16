module univ-rev.
rev1 L K :-
  pi rv\
  (
    (pi M\ rv nil M M),
    (pi X\ pi M\ pi N\ pi R\
        rv (X :: M) R N :- rv M (X :: R) N
    )
  )
  => rv L nil K.

rev2 L K :-
  pi rv\
    (pi X\ pi P\ pi Q\ rv (X :: P) Q :- rv P (X :: Q))
    => rv nil K
    => rv L nil.

module maybe.

withDefault B nothing  B.
withDefault _ (just A) A.

runMaybe _ B nothing  B.
runMaybe P _ (just A) B :- P A B.

sumMaybe _ nothing  nothing nothing :- !.
sumMaybe _ nothing  MB       MB :- !.
sumMaybe _ MA       nothing  MA :- !.
sumMaybe P (just A) (just B) (just C) :- P A B C, !.
sumMaybe _ _ _ nothing.

try P (just A) :- P A, !.
try P nothing.

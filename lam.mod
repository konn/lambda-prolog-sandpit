module lam.

well-formed (app L R)    :- well-formed L, well-formed R.
well-formed (labs x\B x) :-
  pi x\ well-formed x => well-formed (B x).


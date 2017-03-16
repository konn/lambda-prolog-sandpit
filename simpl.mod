module simpl.
accumulate lists.

reify (X\ X)         var-x.
reify (X\ F X + G X) (F' ++ G') :- reify F F', reify G G'.
reify (X\ F X * G X) (F' ** G') :- reify F F', reify G G'.
reify (X\ F X - G X) (F' -- G') :- reify F F', reify G G'.
reify (X\ F X / G X) (F' // G') :- reify F F', reify G G'.
reify (X\ ~ (F X))   (~~ F')    :- reify F F'.
reify (X\ A)         (lit A).
reify (X\ sin (F X)) (app sin F') :- reify F F'.
reify (X\ cos (F X)) (app cos F') :- reify F F'.
reify (X\ arctan (F X)) (app arctan F') :- reify F F'.
reify (X\ ln (F X)) (app ln F') :- reify F F'.
reify (X\ sqrt (F X)) (app sqrt F') :- reify F F'.

interpret var-x (X\ X).
interpret (lit R) (X\ R).
interpret (E ++ E') (X\ F X + F' X) :-
  interpret E F, interpret E' F'.
interpret (E -- E') (X\ F X - F' X) :-
  interpret E F, interpret E' F'.
interpret (E ** E') (X\ F X * F' X) :-
  interpret E F, interpret E' F'.
interpret (E // E') (X\ F X / F' X) :-
  interpret E F, interpret E' F'.
interpret (~~ E) (X\ ~ F X) :- interpret E F.
interpret (app F E) (X\ F (G X)) :-
  interpret E G.

% local split (expr -> expr -> expr) -> expr -> list expr -> o.
split P E LNs :-
  P E A B, !, split P A Ls, split P B Ns, append Ls Ns LNs.
split _ E (E :: []).

simplE F F.

simpl F F' :- reify F E, simplE E E', interpret E' F'.

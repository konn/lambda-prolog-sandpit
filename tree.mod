module tree.
accumulate tuple, lists.
% Simple unbalanced binary tree.

singleton A X (branch A X empty empty).

insertBy P A X empty (branch A X empty empty).
insertBy P A X (branch B Y L R) (branch B Y L' R) :-
  A < B, !, insert A X L L'.
insertBy P A X (branch B Y L R) (branch B Y L R') :-
  B < A, !, insert A X R R'.
insertBy P A X (branch _ Y L R) (branch A Z L R) :-
  P X Y Z.

insert A X T S :- insertBy (X\ Y\ Z\ Z = Y) A X T S.

delete A empty empty.
delete A (branch B X L R) T :- A is B, merge L R T.
delete A (branch B X L R) (branch B X L' R) :-
  B > A, delete A L L'.
delete B (branch B X L R) (branch B X L R') :-
  A > B, delete A R R'.

mergeBy P empty T T :- !.
mergeBy P T empty T :- !.
mergeBy P (branch A X L R) (branch B Y L' R') (branch A X L'' R) :-
  B < A, mergeBy P L (branch B Y L' R') L''.
mergeBy P (branch A X L R) (branch B Y L' R') (branch A X L R'') :-
  A < B, mergeBy P R (branch B Y L' R') R''.
mergeBy P (branch A X L R) (branch A Y L' R') (branch A Z L'' R'') :-
  P X Y Z, mergeBy P L L' L'', mergeBy P R R' R''.

merge L R S :- mergeBy (X\ Y\ Z\ Z = Y) L R S.

lookup A (branch A X _ _) X :- !.
lookup A (branch B X L R) Z :-
  A < B, lookup A L Z.
lookup A (branch B X L R) Z :-
  B < A, lookup A R Z.

list_to_tree Xs T :-
  foldedr (Pr\ Old\ New\ sigma X\ sigma Y\
           Pr = (X pair Y), insert X Y Old New) empty Xs T.

tree_to_list empty [].
tree_to_list (branch A X L R) Xs :-
  tree_to_list L Ls, tree_to_list R Rs,
  append Ls ((A pair X) :: Rs) Xs.

foldTree _ C empty C.
foldTree P C (branch X Y L R) Z :-
  foldTree P C R D,
  P X Y D E,
  foldTree P E L Z.
